
require './lib/snackHack2'
bg = Snackhack2::BannerGrabber.new "https://krebsonsecurity.com"
      bg.run
      puts "\n\n[+] Testing Baner Grabber cURL...\n"
      bg.curl
      puts "\n\n[+] Testing Baner Grabber headers...\n"
      bg.headers