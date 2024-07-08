require "snackhack2"

#wp = Snackhack2::WordPress.new("")
#wp.run

## Grab Banners
s = Snackhack2::BannerGrabber.new("https://google.com")

s.run