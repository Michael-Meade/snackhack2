require 'httparty'
module Snackhack2
	class WordPress
		def initialize(site)
	      @site    = site
    	end
    	def run
    		wp_login
    	end
    	def wp_login
    		percent = 0
    		wp = ["wp-includes", "wp-admin", "Powered by WordPress", "wp-login.php"]
    		login = HTTParty.get("#{@site}/wp-login.php")
    		if login.code == 200
    			wp.each do |path|
    				if login.body.include?(path)
    					percent += 10
    				end
    			end
    		else
    			puts "#{@site}/wp-login.php responded with #{login.code}"
    		end
    		puts "Chances of it being wordpress: #{percent}"
    	end
	end
end