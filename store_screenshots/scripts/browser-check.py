"""Check editor persistence, locale/device controls and real downloaded PNG ZIPs."""
import argparse
import asyncio
import io
import json
import os
import zipfile
from pathlib import Path

from PIL import Image
from playwright.async_api import async_playwright

ROOT = Path(__file__).resolve().parents[1]
PROJECT = ROOT / 'app-store-screenshots.json'
BASE = os.environ.get('BASE', 'http://127.0.0.1:3002')
DEVICES = [('iOS', 'iPhone', 'iphone', (1320, 2868)),
           ('iOS', 'iPhone Duo (outer)', 'duo-outer', (1398, 2034)),
           ('iOS', 'iPhone Duo (inner)', 'duo-inner', (2007, 2853)),
           ('iOS', 'iPad', 'ipad', (2064, 2752)),
           ('Android', 'Android Phone', 'android', (1080, 1920)),
           ('Android', 'Feature Graphic', 'feature-graphic', (1024, 500))]


async def main():
    original = PROJECT.read_bytes()
    state = json.loads(original)
    reports = ROOT / 'reports'
    reports.mkdir(exist_ok=True)
    summary = []
    async with async_playwright() as playwright:
        browser = await playwright.chromium.launch(
            executable_path=os.environ.get('CHROME', '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'),
            headless=True)
        try:
            context = await browser.new_context(viewport={'width': 1600, 'height': 1100}, accept_downloads=True)
            page = await context.new_page()
            errors = []
            page.on('pageerror', lambda error: errors.append(str(error)))
            stale = {**state, 'appName': 'STALE BROWSER CACHE'}
            await page.add_init_script('localStorage.setItem("minimo-photo:store-screenshots:v2", ' +
                                       json.dumps(json.dumps(stale)) + ')')
            await page.goto(BASE, wait_until='networkidle')
            await page.get_by_role('button', name='Export bundle', exact=True).wait_for()
            assert await page.get_by_label('App name', exact=True).input_value() == state['appName']
            await page.wait_for_timeout(1000)
            assert json.loads(PROJECT.read_text())['appName'] == state['appName'], 'Stale cache overwrote Git settings'
            invalid = await context.request.post(BASE + '/api/project', data={'bad': True})
            assert invalid.status == 400
            invalid_png = await context.request.post(BASE + '/api/png', data=b'not a PNG')
            assert invalid_png.status == 400
            assert json.loads(PROJECT.read_text())['appName'] == state['appName']
            await page.get_by_label('App name', exact=True).fill('Persistence check')
            await page.wait_for_timeout(1000)
            assert json.loads(PROJECT.read_text())['appName'] == 'Persistence check'
            await page.get_by_label('App name', exact=True).fill(state['appName'])
            await page.locator('textarea').first.fill('Edited headline')
            await page.wait_for_timeout(1000)
            assert json.loads(PROJECT.read_text())['slidesByDevice']['iphone'][0]['headline']['en'] == 'Edited headline'
            await page.locator('textarea').first.fill(state['slidesByDevice']['iphone'][0]['headline']['en'])
            await page.wait_for_timeout(1000)
            await page.get_by_role('combobox').nth(1).click()
            await page.get_by_role('option', name='RU', exact=True).click()
            await page.wait_for_timeout(1000)
            assert json.loads(PROJECT.read_text())['locale'] == 'ru'
            await page.get_by_role('combobox').nth(1).click()
            await page.get_by_role('option', name='EN', exact=True).click()
            await page.wait_for_timeout(1000)
            await page.screenshot(path=str(reports / 'editor.png'))
            for platform, label, device, dimensions in DEVICES:
                await page.get_by_role('tab', name=platform, exact=True).click()
                await page.get_by_role('combobox').first.click()
                await page.get_by_role('option', name=label, exact=True).click()
                await page.wait_for_timeout(800)
                # Both locales are included by the actual editor export button.
                async with page.expect_download(timeout=180000) as download_info:
                    await page.get_by_role('button', name='Export bundle', exact=True).click()
                download = await download_info.value
                destination = reports / f'browser-{device}.zip'
                await download.save_as(str(destination))
                with zipfile.ZipFile(destination) as archive:
                    locales = [locale for locale in state['locales']
                               if all(locale in slide['headline'] for slide in state['slidesByDevice'][device])]
                    expected = len(state['slidesByDevice'][device]) * len(locales)
                    assert archive.testzip() is None
                    names = [name for name in archive.namelist() if name.endswith(".png")]
                    assert len(names) == expected, (device, names)
                    assert all(any(f'/{locale}/' in name for name in names) for locale in locales)
                    for name in names:
                        with Image.open(io.BytesIO(archive.read(name))) as image:
                            assert image.size == dimensions, (name, image.size)
                            assert any(lo != hi for lo, hi in image.convert('RGB').getextrema()), name
                            assert image.mode == 'RGB', (name, image.mode)
                    # Keep a downloaded file for visual comparison with offline exports.
                    sample = next(name for name in names if '/en/' in name)
                    (reports / f'browser-{device}.png').write_bytes(archive.read(sample))
                summary.append({'device': device, 'pngs': expected, 'size': list(dimensions)})
                print(f'Real Export bundle: {device}, {expected} PNGs validated', flush=True)
            assert not errors, errors
            (reports / 'browser-check.json').write_text(json.dumps({'exports': summary, 'errors': errors,
                'persistence': 'passed', 'staleCache': 'passed', 'invalidProject': 'rejected'}, indent=2)+'\n')
        finally:
            await browser.close()
            PROJECT.write_bytes(original)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--devices', nargs='+', choices=[device[2] for device in DEVICES])
    args = parser.parse_args()
    if args.devices:
        DEVICES = [device for device in DEVICES if device[2] in args.devices]
    asyncio.run(main())
