"""Export saved decks, creatives, contact sheets and ZIPs; requires running editor."""
import argparse
import asyncio
import json
import os
import zipfile
from pathlib import Path

from PIL import Image, ImageDraw
from playwright.async_api import async_playwright

ROOT = Path(__file__).resolve().parents[1]
DECKS = [('iphone', 1320, 2868, 'apple/iphone-6.9'),
         ('duo-outer', 1398, 2034, 'apple/iphone-duo-outer'),
         ('duo-inner', 2007, 2853, 'apple/iphone-duo-inner'),
         ('ipad', 2064, 2752, 'apple/ipad-13'),
         ('android', 1080, 1920, 'android/phone')]
BUNDLE_SUFFIX = ''
BANNERS = [('header', 3840, 1646, 'apple/header'),
           ('search', 3840, 2560, 'apple/search-results'),
           ('play', 1024, 500, 'android/feature-graphic')]


def jobs(state):
    for locale in state['locales']:
        for device, w, h, folder in DECKS:
            if not all(locale in slide['headline'] for slide in state['slidesByDevice'][device]):
                continue
            for index, _ in enumerate(state['slidesByDevice'][device]):
                yield (f'/preview?device={device}&locale={locale}&bare&from={index}&n=1',
                       w, h, ROOT / 'export' / folder / locale / f'{index+1:02d}.png')
        for kind, w, h, folder in BANNERS:
            yield (f'/creative?kind={kind}&locale={locale}', w, h,
                   ROOT / 'export' / folder / locale / '01.png')


def check_png(path, w, h):
    with Image.open(path) as image:
        assert image.size == (w, h), (path, image.size)
        assert image.mode == 'RGB', (path, image.mode)
        assert any(lo != hi for lo, hi in image.getextrema()), f'Blank PNG: {path}'


def check(state):
    expected = list(jobs(state))
    for _, w, h, path in expected:
        check_png(path, w, h)
    for locale in [*state['locales'], 'all']:
        paths = [p for _, _, _, p in expected if locale == 'all' or p.parent.name == locale]
        with zipfile.ZipFile(ROOT / 'export' / f'minimo-photo{BUNDLE_SUFFIX}-{locale}.zip') as archive:
            assert archive.testzip() is None
            assert set(archive.namelist()) == {str(p.relative_to(ROOT / 'export')) for p in paths}
    print(f'Checked {len(expected)} RGB PNGs and {len(state["locales"])+1} ZIPs', flush=True)


def contact(paths, target, height=440, labels=False, columns=6):
    thumbs = []
    for path in paths:
        with Image.open(path) as image:
            thumb = image.convert('RGB')
            thumb.thumbnail((900, height))
            thumbs.append(thumb.copy())
    if not thumbs:
        return
    width = max(t.width for t in thumbs)
    cell_h = height + (28 if labels else 0)
    sheet = Image.new('RGB', (columns * (width + 16) + 16,
                             ((len(thumbs)+columns-1)//columns) * (cell_h+16)+16), '#f1f2f6')
    draw = ImageDraw.Draw(sheet)
    for index, (thumb, path) in enumerate(zip(thumbs, paths)):
        x, y = 16 + index % columns * (width+16), 16 + index // columns * (cell_h+16)
        sheet.paste(thumb, (x + (width-thumb.width)//2, y))
        if labels:
            draw.text((x, y+height+6), str(path.relative_to(ROOT / 'export')), fill='#272727')
    target.parent.mkdir(parents=True, exist_ok=True)
    sheet.save(target)


def package(state):
    expected = list(jobs(state))
    for locale in [*state['locales'], 'all']:
        with zipfile.ZipFile(ROOT / 'export' / f'minimo-photo{BUNDLE_SUFFIX}-{locale}.zip', 'w', zipfile.ZIP_DEFLATED) as archive:
            for _, _, _, path in expected:
                if locale == 'all' or path.parent.name == locale:
                    archive.write(path, str(path.relative_to(ROOT / 'export')))
    for device, _, _, folder in DECKS:
        paths = [p for _, _, _, p in expected if str(p).startswith(str(ROOT / 'export' / folder))]
        contact(paths, ROOT / 'export/previews' / f'{device}.png', labels=True)
    for locale in state['locales']:
        paths = [p for _, _, _, p in expected if p.parent.name == locale and 'iphone-6.9' in str(p)]
        contact(paths, ROOT / 'export/previews' / f'{locale}.png')
    paths = [p for _, _, _, p in expected if any(folder in str(p) for _, _, _, folder in BANNERS)]
    contact(paths, ROOT / 'export/previews/banners.png', height=400, labels=True, columns=3)
    # Explicit Git exception: this single clean overview is public README artwork.
    paths = [p for _, _, _, p in expected if p.parent.name == 'en' and 'iphone-6.9' in str(p)]
    contact(paths, ROOT.parent / 'docs/images/store-preview.png', height=600)


async def export(state, base):
    async with async_playwright() as playwright:
        browser = await playwright.chromium.launch(
            executable_path=os.environ.get('CHROME', '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'),
            headless=True)
        try:
            page = await browser.new_page(device_scale_factor=1)
            errors = []
            page.on('pageerror', lambda error: errors.append(str(error)))
            for url, w, h, path in jobs(state):
                errors.clear()
                await page.set_viewport_size({'width': w, 'height': h})
                await page.goto(base + url, wait_until='networkidle')
                await page.evaluate('document.fonts.ready')
                await page.wait_for_function('''() => document.images.length > 0 &&
                    [...document.images].every(img => img.complete && img.naturalWidth > 0)''')
                await page.evaluate('new Promise(r => requestAnimationFrame(() => requestAnimationFrame(r)))')
                assert not errors, (url, errors)
                assert await page.evaluate('document.fonts.check("20px Pangolin")'), 'Pangolin missing'
                overflow = await page.evaluate('''() => [...document.querySelectorAll('[data-fit-text]')].flatMap(el => {
                    const bounds = el.getBoundingClientRect();
                    const range = document.createRange(); range.selectNodeContents(el);
                    return [...range.getClientRects()].some(r => r.left < bounds.left-2 || r.right > bounds.right+2)
                        ? [el.innerText] : [];
                })''')
                assert not overflow, (url, 'Text overflow', overflow)
                path.parent.mkdir(parents=True, exist_ok=True)
                await page.screenshot(path=str(path), animations='disabled')
                with Image.open(path) as image:
                    image.convert('RGB').save(path)
                print(path.relative_to(ROOT), flush=True)
        finally:
            await browser.close()
    package(state)
    check(state)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--base', default='http://127.0.0.1:3002')
    parser.add_argument('--check', action='store_true')
    parser.add_argument('--devices', nargs='+', choices=[d[0] for d in DECKS])
    parser.add_argument('--locale', choices=['en', 'ru'])
    args = parser.parse_args()
    BUNDLE_SUFFIX = '-' + '-'.join(args.devices) if args.devices else ''
    if args.devices:
        DECKS = [d for d in DECKS if d[0] in args.devices]
        BANNERS = []
    state = json.loads((ROOT / 'app-store-screenshots.json').read_text())
    if args.locale:
        state['locales'] = [args.locale]
    if args.check:
        check(state)
    else:
        asyncio.run(export(state, args.base))
