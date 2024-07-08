require "snackhack2"

wp = Snackhack2::WordPress.new("https://kinsta.com")
wp.run

## Grab Banners
##s = Snackhack2::BannerGrabber.new("https://google.com")

#s.run