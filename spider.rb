require './lib/snackHack2'
require 'httparty'
require 'nokogiri'
sites = []
a = Snackhack2::WebsiteMeta.new
File.readlines("top-10000-domains.txt").each do |domain|
	a.site  = domain.strip
	d       = a.description
	if !d.nil?
		sites << [ d, domain.strip ]
	end
	#sites << [ domain.strip, a.description.to_s ]
	p sites
end
