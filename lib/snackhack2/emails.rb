require 'httparty'
require 'spidr'
module Snackhack2
	class Email
		attr_accessor :max_depth
		def initialize(site, save_file: true, max_depth: 4)
			@site = site
			@save_file = save_file
			@max_depth = max_depth
	  	end
	  	def max_depth
	  		@max_depth
	  	end
	  	def run
	  		found_emails = []
	  		Spidr.start_at(@site, max_depth: @max_depth) do |agent|
	  			agent.every_page do |page|
					body = page.to_s
					if body.scan(/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/)
						email = body.scan(/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/).uniq
						if !email.include?(found_emails)
							if !email.empty?
								found_emails << email
							end
						end
					end
				end
			end
			Snackhack2::file_save(@site, "emails", found_emails.uniq.join("\n")) if @save_file
	  	end
	end
end