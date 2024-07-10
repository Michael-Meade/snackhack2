require 'httparty'
module Snackhack2
	class GoogleAnalytics
		attr_reader :site
		def initialize(site)
      		@site = site
    	end
    	def run
    		a = HTTParty.get(@site).body
    		if a.match(/UA-\d{8}-\d/)
    			puts a.match(/UA-\d{8}-\d/)
    		elsif a.match(/GTM-[A-Z0-9]{7}/)
    			puts a.match(/GTM-[A-Z0-9]{7}/)
    		elsif a.match(/G-([0-9]+([A-Za-z]+[0-9]+)+)/)
    			puts a.match(/G-([0-9]+([A-Za-z]+[0-9]+)+)/)
    		else
    			puts "[+] No Google Analytics found :("
    		end
    	end
	end
end