require 'net/http'
require 'openssl'
module Snackhack2
	class SSLCert
		attr_accessor :site

	    def initialize
	    	@site = site
	    end
		def get_cert
			begin
				if @site.downcase.include?("https://")
					@site = @site.downcase.gsub("https://", "")
				end
				uri = URI::HTTPS.build(host: @site)
				response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true)
				cert = response.peer_cert
				puts cert.serial
			rescue OpenSSL::SSL::SSLError,Net::OpenTimeout, Errno::EHOSTUNREACH
			end
		end
	end
end
