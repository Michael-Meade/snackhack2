
#require './lib/snackHack2'
require "snackhack2"
bg = Snackhack2::BannerGrabber.new
bg.site = "https://krebsonsecurity.com"
bg.run
puts "\n\n[+] Testing Baner Grabber cURL...\n"
bg.curl
puts "\n\n[+] Testing Baner Grabber headers...\n"
puts bg.headers