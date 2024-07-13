# frozen_string_literal: true

require './lib/snackHack2'
# ### Banner Grabber
#
# s = Snackhack2::BannerGrabber.new("https://google.com")
# s.curl
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

# wp = Snackhack2::WordPress.new('https://kinsta.com')
# wp.run

# me = Snackhack2::WebsiteMeta.new('https://kinsta.com')
# me.run

# t = Snackhack2::GoogleAnalytics.new("https://www.googletagmanager.com/gtag/js?id=G-SL8LSCXHSV")

# t.run

# bg =  Snackhack2::Main.new("https://google.com")

# bg.website_meta
# ca = Snackhack2::CryptoExtractWebsite.new("https://google.com")
# puts ca.save_file
# ca.save_file = false
# ca.run
#
# wp = Snackhack2::WordPress.new("https://themeisle.com", save_file: false)
# wp.save_file = false
# wp.users
# links = Snackhack2::WebsiteLinks.new('https://www.bleepingcomputer.com/news/security/signal-downplays-encryption-key-flaw-fixes-it-after-x-drama/')
# links.run

#Snackhack2::WebServerCleaner.new('83.149.9.216').run
#ga = Snackhack2::GoogleAnalytics.new("https://g-form.com")
#ga.run