# frozen_string_literal: true

require 'snackhack2'
require 'optparse'
require 'uri'
options = {}
OptionParser.new do |opts|
  opts.banner = 'Usage: example.rb [options]'

  opts.on('--ga ', '--ga=SITE', 'Find Google Analytics G codes.') do |v|
    options[:ga] = v
  end
  opts.on('--links ', '--links=SITE', 'Get all Links from a site.') do |v|
    options[:links] = v
  end
  opts.on('--meta ', '--meta=SITE', 'Get all the META data from a site') do |v|
    options[:meta] = v
  end
  opts.on('--weblogclear ', '--weblogclear=SITE', 'Remove an IP from web logs and replace it with a random IP.') do |v|
    options[:weblogclear] = v
  end
  opts.on('--cryptoextract', '--cryptoextract=SITE', 'Find Crypto addresses found in sites.') do |v|
    options[:cryptoextract] = v
  end
  opts.on('--bannergrab', '--bannergrab=SITE', 'Grab the banner of a site.') do |v|
    options[:bannergrab] = v
  end
  opts.on('--curl', '--curl=SITE', "Use cURL to get a site's banner") do |v|
    options[:curl] = v
  end
  opts.on('--subdomain', '--subdomain=SITE', "Get a site's subdomains via DNS.") do |v|
    options[:subdomain] = v
  end
  opts.on('--robots', '--robots=SITE', 'Check robots.txt') do |v|
    options[:curl] = v
  end
  opts.on('--phonenumber', '--phonenumber=SITE', 'Crawl a website looking for phone numbers') do |v|
    options[:phonenumber] = v
  end
  opts.on('--drupal', '--drupal=SITE', 'Detect drupal') do |v|
    options[:drupal] = v
  end
  opts.on('--weblog', '--weblog=IP', 'Replace a certain IP in the web server logs.') do |v|
    options[:weblog] = v
  end
  opts.on('--tomcat', '--tomcat=IP', 'Check for Tomcat') do |v|
    options[:tomcat] = v
  end
  opts.on('--emails', '--emails=IP', 'Crawl a site looking for Emails.') do |v|
    options[:emails] = v
  end
end.parse!

if options[:ga]
  t = Snackhack2::GoogleAnalytics.new(options[:ga])
  t.run
end
if options[:links]
  links = Snackhack2::WebsiteLinks.new(options[:links])
  links.run
  new_link = options[:links].gsub('https://', '')
  puts "Saving links from #{new_link}_links.txt"
end
if options[:meta]
  me = Snackhack2::WebsiteMeta.new(options[:meta])
  me.run
end
Snackhack2::WebServerCleaner.new(options[:weblogclear]).run if options[:weblogclear]
if options[:cryptoextract]
  Snackhack2::CryptoExtractWebsite.new(options[:cryptoextract]).run
end
Snackhack2::BannerGrabber.new(options[:bannergrab]).run if options[:bannergrab]
Snackhack2::BannerGrabber.new(options[:curl]).curl if options[:curl]
Snackhack2::Subdomains.new(options[:subdomain]).run if options[:subdomain]
if options[:robots]
  ip = Snackhack2::Robots.new(options[:robots], save_file: true)
  ip.run
end
if options[:phonenumber]
  wp = Snackhack2::PhoneNumber.new(options[:phonenumber])
  wp.spider
end
if options[:drupal]
  d = Snackhack2::Drupal.new(options[:drupal])
  d.all
end

if options[:tomcat]
	tc = Snackhack2::TomCat.new(options[:tomcat])
	tc.run
end
if options[:emails]
  Snackhack2::Email.new(options[:emails]).run
end