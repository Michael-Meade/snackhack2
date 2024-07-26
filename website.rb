require 'snackhack2'
require 'colorize'
print("Enter URL (with HTTPS://): ")
url=gets.chomp
print("\n\n\n")


puts "[+] Checking for Drupal...\n".red
Snackhack2::Drupal.new(url).all
puts"--------\n"

puts "[+] Checking for WordPress...\n".red
Snackhack2::WordPress.new(url).run
puts"--------\n"

puts "[+] Checking for TomCat...\n".red
Snackhack2::TomCat.new(url)
puts"--------\n"

puts "[+] Checking the site for Google Analytics...\n".red
Snackhack2::GoogleAnalytics.new(url).run
puts"--------\n"

puts "[+] Grabbing the Banner...\n".red
Snackhack2::BannerGrabber.new(url).run
puts"--------\n"

puts "[+] Checking Robots.txt...\n".red
Snackhack2::Robots.new(url).run
puts"--------\n"

