"""Restore ignored editor assets from tracked app assets and public demo photos."""
import argparse
import hashlib
import io
import json
import shutil
import subprocess
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont, ImageOps

ROOT = Path(__file__).resolve().parents[1]
PUBLIC = ROOT / 'public'
COMPARE_LABELS = {'en': ('before', 'after'), 'ru': ('было', 'стало')}

def download(url):
    return subprocess.check_output(['curl', '--fail', '--location', '--silent', '--show-error',
                                    '--max-time', '45', '--retry', '2', url])

def restore(photos_dir=None):
    sources = json.loads((ROOT / 'asset-sources.json').read_text())
    for folder in ['fonts', 'brand', 'photos']:
        (PUBLIC / folder).mkdir(parents=True, exist_ok=True)
    shutil.copy2(ROOT.parent / 'assets/logo/logo.png', PUBLIC / 'app-icon.png')
    shutil.copy2(ROOT.parent / 'assets/fonts/Pangolin-Regular.ttf', PUBLIC / 'fonts/Pangolin-Regular.ttf')
    for name, filename in [('background.png', 'sky.jpg'), ('background_dark.png', 'sky-dark.jpg')]:
        Image.open(ROOT.parent / 'assets/images' / name).convert('RGB').save(PUBLIC / 'brand' / filename)
    shutil.copy2(PUBLIC / 'brand/sky.jpg', PUBLIC / 'brand/sky-wide.jpg')
    if not (PUBLIC / 'mockup.png').exists():
        data = download(sources['mockup']['url'])
        assert hashlib.sha256(data).hexdigest() == sources['mockup']['sha256'], 'Mockup checksum mismatch'
        assert Image.open(io.BytesIO(data)).size == (1022, 2082)
        (PUBLIC / 'mockup.png').write_bytes(data)
    for name, identifier in sources['photos'].items():
        target = PUBLIC / 'photos' / f'{name}.jpg'
        if photos_dir:
            image = Image.open(Path(photos_dir) / f'{name}.jpg').convert('RGB')
        elif target.exists():
            image = Image.open(target).convert('RGB')
        else:
            image = Image.open(io.BytesIO(download(f'https://images.unsplash.com/{identifier}?w=2400&q=96'))).convert('RGB')
        image = ImageOps.fit(image, (2400, 1800))
        if not target.exists() or photos_dir:
            image.save(target, quality=96)
        image.save(PUBLIC / 'photos' / f'{name}-small.jpg', quality=82)
        assert Image.open(target).size == (2400,1800)
    render_compare()
    print('Restored icon, Pangolin, backgrounds, mockup, five demo photo pairs and compare images')

def render_compare(width=1600, height=1200):
    """Left half is the original demo photo, right half its quality-82 copy, with real file sizes."""
    before_path, after_path = PUBLIC / 'photos/beach.jpg', PUBLIC / 'photos/beach-small.jpg'
    before = ImageOps.fit(Image.open(before_path).convert('RGB'), (width, height))
    after = ImageOps.fit(Image.open(after_path).convert('RGB'), (width, height))
    sizes = [f'{path.stat().st_size / 1024:.1f} KB' for path in (before_path, after_path)]
    font = ImageFont.truetype(str(PUBLIC / 'fonts/Pangolin-Regular.ttf'), 64)
    badge_font = ImageFont.truetype(str(PUBLIC / 'fonts/Pangolin-Regular.ttf'), 84)
    for locale, labels in COMPARE_LABELS.items():
        image = before.copy()
        image.paste(after.crop((width // 2, 0, width, height)), (width // 2, 0))
        overlay = Image.new('RGBA', image.size, (0, 0, 0, 0))
        draw = ImageDraw.Draw(overlay)
        draw.rectangle((width // 2 - 4, 0, width // 2 + 4, height), fill=(255, 255, 255, 255))
        for index, (label, size) in enumerate(zip(labels, sizes)):
            text = f'{label} · {size}'
            box = draw.textbbox((0, 0), text, font=font)
            pill_w, pill_h = box[2] - box[0] + 88, 124
            x = 44 if index == 0 else width - 44 - pill_w
            draw.rounded_rectangle((x, 44, x + pill_w, 44 + pill_h), radius=pill_h // 2, fill=(39, 39, 39, 205))
            draw.text((x + pill_w / 2, 44 + pill_h / 2), text, font=font, fill='white', anchor='mm')
        radius = 104
        center = (width // 2, height // 2)
        draw.ellipse((center[0] - radius - 10, center[1] - radius - 10, center[0] + radius + 10, center[1] + radius + 10), fill='white')
        draw.ellipse((center[0] - radius, center[1] - radius, center[0] + radius, center[1] + radius), fill='#FC3636')
        draw.text(center, 'VS', font=badge_font, fill='white', anchor='mm')
        Image.alpha_composite(image.convert('RGBA'), overlay).convert('RGB').save(PUBLIC / f'brand/compare-{locale}.png')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--photos-dir', help='Optional folder containing beach/dog/birthday/mountains/concert.jpg')
    restore(parser.parse_args().photos_dir)
