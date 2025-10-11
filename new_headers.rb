require './lib/snackHack2'
bg = Snackhack2::BannerGrabber.new
bg.site = "https://hackex.net"

#cf = bg.cloudflare

#puts "\nStatus: Cloudflare found.\nCount: #{cf[1]}" if cf[0]


bg.aws_cloudfront