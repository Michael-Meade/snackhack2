require './lib/snackHack2'
ssl =  Snackhack2::SSLCert.new

ssl.site = "https://google.com"
ssl.get_cert