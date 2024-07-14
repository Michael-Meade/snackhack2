# frozen_string_literal: true
#require 'nokogiri'
#require 'open-uri'
require './lib/snackHack2'
=begin
document = Nokogiri::HTML.parse(URI.open('https://porchlightshop.com/wp-content/uploads'))

tags = document.xpath("//a")
tags.each do |t|
	puts t[:href]
end
=end


# Banner Grabber
# s = Snackhack2::BannerGrabber.new("https://google.com")
# s.curl


### Word Press

# wp = Snackhack2::WordPress.new("https://google.com")
# wp.run
=begin
["https://google.com", "https://kinsta.com", "https://porchlightshop.com", "https://www.drrajatgupta.com"].each do |site|
	wp = Snackhack2::WordPress.new(site)
	puts "#{site}: "
	wp.run
	puts "\n"
end

=end

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

# me = Snackhack2::WebsiteMeta.new('https://kinsta.com')
# me.run

## Grab gooogle Analytics from a site. this could be used to find similar sites 

# t = Snackhack2::GoogleAnalytics.new("https://www.googletagmanager.com/gtag/js?id=G-SL8LSCXHSV")

# t.run

## Extract a bunch of different types of crypto addresses from a site.

# ca = Snackhack2::CryptoExtractWebsite.new("https://google.com")
# puts ca.save_file
# ca.save_file = false
# ca.run


## Detect the chances of the site being wordpress.

# wp = Snackhack2::WordPress.new("https://themeisle.com", save_file: false)
# wp.save_file = false
# wp.users

## Get all the links of a site.

#links = Snackhack2::WebsiteLinks.new('https://www.drrajatgupta.com/wp-content/uploads/')
#links.run

## Remove all the occurrences of the given IP and replaces it with an random IP. 

# Snackhack2::WebServerCleaner.new('83.149.9.216').run



# ga = Snackhack2::GoogleAnalytics.new("https://g-form.com")
# ga.run

=begin
["https://google.com", "https://kinsta.com", "https://porchlightshop.com", "https://www.drrajatgupta.com"].each do |site|
	s = Snackhack2::BannerGrabber.new(site)
	puts s.curl
end
=end
#Snackhack2::read_serverversion
#Snackhack2::clean_serverversion

Snackhack2::IpLookup.new("https://google.com").run