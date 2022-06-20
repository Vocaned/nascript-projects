from PIL import Image
from nums import table

symbols = Image.open('symbols.png')

bg = symbols.crop((0, 0, 16, 16))
bg2 = symbols.crop((16, 0, 32, 16))

img = Image.new('RGBA', (256, 512), 0x00000000)
pixels = img.load()

for i in range(512):
    x = (i * 16) % 256
    y = i // 16 * 16

    img.paste(bg if i <= 256 or i % 2 == (i//16)%2 else bg2, (x, y))

    if i > 0 and i <= 256:
        num = str(i-1).rjust(3, '0')
        numoffset = 0
        for n in num:
            px = table[n]
            for h in range(6):
                for w in range(4):
                    if px[w%4+(4*h)]:
                        pixels[x+1+w+numoffset, y+5+h] = (0, 0, 0, 255)
            numoffset += 5


img.paste(symbols, (img.width-symbols.width, img.height-symbols.height))
img.save('terrain.png')
