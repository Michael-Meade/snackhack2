# frozen_string_literal: true

require_relative '../lib/snackHack2'
require 'colorize'
#print('Enter URL (with HTTPS://): ')

#url = gets.chomp
url = "https://abc.com"
print("\n\n\n")

puts "[+] Checking for Drupal...\n".red
d = Snackhack2::Drupal.new
d.site = url
d.all
puts "--------\n"

puts "[+] Checking for WordPress...\n".red
wp = Snackhack2::WordPress.new
wp.site = url
wp.run
puts "--------\n"

puts "[+] Checking for TomCat...\n".red
tc = Snackhack2::TomCat.new
tc.site = url
tc.run
puts "--------\n"

puts "[+] Checking the site for Google Analytics...\n".red
ga = Snackhack2::GoogleAnalytics.new

ga.site = url
ga.run
puts "--------\n"

puts "[+] Grabbing the Banner...\n".red
bg = Snackhack2::BannerGrabber.new
bg.site = url
bg.run
puts "--------\n"

puts "[+] Checking Robots.txt...\n".red
r = Snackhack2::Robots.new(url)
r.run
puts "--------\n"


puts "[+] Getting HTML comments\n".red
c = Snackhack2::Comments.new
c.site = "https://abc.com"
c.run
puts "--------\n"

puts "[+] Getting Site's SSL Cert\n".red

ssl =  Snackhack2::SSLCert.new

ssl.site = "https://google.com"
ssl.get_cert

puts "--------\n"

puts "[+] Getting links of a site\n".red

sl = Snackhack2::WebsiteLinks.new

sl.site = "https://abc.com"
sl.run

puts "--------\n"

puts "[+] Getting a website's META data\n".red


meta = Snackhack2::WebsiteMeta.new
meta.site = "https://abc.com"
meta.run

puts "--------\n" 

puts "[+] Getting a website's META descriptio\n".red
meta.description
puts "--------\n"


puts "[+] Getting a website's site.xml\n".red
xml = Snackhack2::SiteMap.new
xml.site = "https://michaelmeade.org"
xml.run


puts "--------\n"


puts "[+] Getting a website's dns records\n".red

dns = Snackhack2::Dns.new
dns.site = "abc.com"
puts "A Record: "
dns.a.each do |a|
	puts a
end
puts "\n\n\n"
puts "NamerServer: "
dns.nameserver.each do |ns|
	puts ns
end
puts "\n\n\n"
puts "SOA: "
dns.soa.each do |s|
	puts s
end
puts "\n\n\n"
puts "TXT: "
dns.txt.each do |txt|
	puts txt
end
puts "\n\n\n"
puts "AAAAA: "
dns.aaaa.each do |a|
	puts a
end
puts "\n\n\n"
puts "hinfo: "
dns.hinfo.each do |h|
	puts h
end

puts "\n\n\n"
puts "mx: "
dns.mx.each do |mx|
	puts mx
end