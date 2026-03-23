require 'net/http'
require 'openssl'
module Snackhack2
	class SSLCert
		attr_accessor :site, :file_save

	    def initialize
	    	@site = site
	    	@file_save = false
	    end
		def get_cert(print_status: false)
			save_txt_file = ''
			begin
				if @site.downcase.include?("https://")
					@site = @site.downcase.gsub("https://", "")
				end
				uri = URI::HTTPS.build(host: @site)
				response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true)
				cert = response.peer_cert
				if @file_save
					save_txt_file += cert.serial
				else 
					if print_status
						puts cert.serial
					else
						return cert.serial
					end
				end
			rescue OpenSSL::SSL::SSLError,Net::OpenTimeout, Errno::EHOSTUNREACH
			end
		Snackhack2.file_save(@site, 'ssl', save_txt_file) if @file_save
		end
	end
end
