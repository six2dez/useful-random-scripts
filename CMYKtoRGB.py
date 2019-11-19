from PIL import Image
import os

result = [os.path.join(dp, f) for dp, dn, filenames in os.walk('/images') for f in filenames if os.path.splitext(f)[1] == '.jpg']
for portada in result:
    image = Image.open(portada)
    if image.mode == 'CMYK':
        image = image.convert('RGB').save(portada)
        print(portada+" converted")