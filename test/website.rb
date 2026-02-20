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
