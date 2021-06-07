#!/usr/bin/env python

# This programm runs with Python 2.X
# See https://docs.python.org/2/howto/urllib2.html
#     https://stackoverflow.com/questions/1843422/get-webpage-contents-with-python

import urllib2

# response = urllib2.urlopen('http://python.org/')
opener = urllib2.build_opener()
opener.addheaders = [('User-agent', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) snap Chromium/74.0.3729.169 Chrome/74.0.3729.169 Safari/537.36'),
		     ( 'Accept','text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3')]

response = opener.open('http://s200683803.onlinehome.fr/old-now-move/facebook/flashGames/ebook.php?q=information-and-exponential-families-in-statistical-theory-1978.html')
#response = opener.open('/home/francisco/websites/bbbb/s200683803.onlinehome.fr/old-now-move/facebook/flashGames/ebook583f.html')
html = response.read()
print(html)
