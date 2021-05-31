#!/usr/bin/env python
import webbrowser

BACKOFFICE_COMMONS='https://gitlab.uniscon-rnd.de/idgard-backend/backoffice-commons/merge_requests'
EXPORT_JOB='https://gitlab.uniscon-rnd.de/idgard-backend/export-job/merge_requests'
VC_DASHBOARD='https://gitlab.uniscon-rnd.de/idgard-backend/vc-dashboard/merge_requests'

urls = [BACKOFFICE_COMMONS, EXPORT_JOB, VC_DASHBOARD] 

# Fetch the instance of the specific browser, in this case chromium. See the browsers here: https://docs.python.org/3.3/library/webbrowser.html
specificBrowser = webbrowser.get(using='chromium');

# open in a new tab, if possible
newWindow = 2;

for url in urls:
	#Open the url with Chromium
	specificBrowser.open(url,newWindow)
	
	#Open the URL with the default browser
	# webbrowser.open(url, new=2) 




