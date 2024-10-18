require './lib/snackHack2'
require 'colorize'
print("Enter URL ( with https:// ):")
url = gets.chomp

puts "WordPress\n\n".blue
wp = Snackhack2::WordPress.new(url)
wp.users
puts "\n\n"

puts "Port Scan the Site\n\n".green
ps = Snackhack2::PortScan.new
ps.ip = url.gsub("https://", "")
ps.run
puts "\n\n"

puts "WebSite META DATA\n\n".red
Snackhack2::WebsiteMeta.new(url).run
puts "\n\n"

puts "Get ALL Links...\n\n\n".yellow

Snackhack2::WebsiteLinks.new(url).run
