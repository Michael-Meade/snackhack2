# frozen_string_literal: true

require './lib/snackHack2'
# ### Banner Grabber
#
#s = Snackhack2::BannerGrabber.new("https://google.com")
#s.curl
#
### Word Press
#
# wp = Snackhack2::WordPress.new("https://google.com")
# wp.run
#
### Port Scan
# tcp = Snackhack2::PortScan.new("167.71.98.134")
# tcp.run
#
### Robots
# ip = Snackhack2::Robots.new("https://google.com", save_file: true)
# puts ip.run
#
# sd = Snackhack2::Subdomains.new("https://ruby-lang.org")
#
# sd.run
# Snackhack2::SSHBute.new("167.98.80.8").run

#wp = Snackhack2::WordPress.new('https://kinsta.com')
#wp.run

#me = Snackhack2::WebsiteMeta.new('https://kinsta.com')
#me.run

#t = Snackhack2::GoogleAnalytics.new("https://g-form.com")

#t.run

#bg =  Snackhack2::Main.new("https://google.com")

#bg.website_meta

ca = Snackhack2::CryptoExtractWebsite.new("https://www.coincarp.com/currencies/tron/richlist/")
ca.run