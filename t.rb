# frozen_string_literal: true

require 'snackhack2'
require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("--ga ", "--ga=SITE", "Find Google Analytics G codes.") do |v|
    options[:ga] = v
  end
  opts.on("--links ", "--links=SITE", "Get all Links from a site.") do |v|
    options[:links] = v
  end
   opts.on("--meta ", "--meta=SITE", "Get all the META data from a site") do |v|
    options[:meta ] = v
  end
  opts.on("--weblogclear ", "--weblogclear=SITE", "Remove an IP from web logs and replace it with a random IP.") do |v|
    options[:weblogclear] = v
  end
  opts.on("--cryptoextract", "--cryptoextract=SITE", "Find Crypto addresses found in sites.") do |v|
    options[:cryptoextract] = v
  end
   opts.on("--bannergrab", "--bannergrab=SITE", "Grab the banner of a site.") do |v|
    options[:bannergrab] = v
  end
  opts.on("--curl", "--curl=SITE", "Use cURL to get a site's banner") do |v|
    options[:curl] = v
  end
  opts.on("--subdomain", "--subdomain=SITE", "Get a site's subdomains via DNS.") do |v|
    options[:curl] = v
  end
end.parse!


if options[:ga]
	t = Snackhack2::GoogleAnalytics.new(options[:ga])
	t.run
end
if options[:links]
	links = Snackhack2::WebsiteLinks.new(options[:links])
	links.run
	new_link = options[:links].gsub("https://", "")
	puts "Saving links from #{new_link}_links.txt"
end
if options[:meta]
	me = Snackhack2::WebsiteMeta.new(options[:meta])
	me.run
end
if options[:weblogclear]
	Snackhack2::WebServerCleaner.new(options[:weblogclear]).run
end
if options[:cryptoextract]
	new_link = options[:cryptoextract].gsub("https://", "")
	puts "Saving links to file..."
	ca = Snackhack2::CryptoExtractWebsite.new(options[:cryptoextract]).run
end
if options[:bannergrab]
	s = Snackhack2::BannerGrabber.new(options[:bannergrab]).run
end
if options[:curl]
	s = Snackhack2::BannerGrabber.new(options[:curl]).curl
end
if options[:subdomain]
	Snackhack2::Subdomains.new(options[:subdomain]).run
end