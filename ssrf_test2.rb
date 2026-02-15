require './lib/snackHack2'

ssrf = Snackhack2::SSRF.new

ssrf.site = "http://127.0.0.1:10/?url=SSRF"
ssrf.ssrf_site = "http://localhost"
# set the protocol.
ssrf.protocol = "https"

# Test ssrf with google.com
ssrf.ssrf_google

# HTTP port scan
p ssrf.http_port_scan