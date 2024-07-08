module Snackhack2
	class IpLookup
		def initialize(site)
			@site = site
		end
		def run
			get_ip
			nslookup
		end
		def get_ip
			ips = []
			ip = `ping -c 2 #{@site}`.lines
			ip.each do |l|
				new_ip = l.match(/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/)
				if !ips.include?(new_ip) 
					ips << new_ip.to_s
				end
			end
			puts "IP via ping: #{ips.shift}\n\n\n\n"
		end
		def nslookup
			ns = `nslookup #{@site}`.lines
			ns.each do |ip|
				if ip.include?("Address")
					puts ip
				end
			end
		end
	end
end