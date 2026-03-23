require_relative '../lib/snackHack2'

ssl =  Snackhack2::SSLCert.new

count = 0
File.readlines("top-1000000-domains.txt").each do |site|
	site = site.strip
	ssl.site = "https://#{site}"
	begin
		puts "count: #{count}\n"

		s = ssl.get_cert(print_status: false)
		puts "#{s}:#{site}\n"
		unless s.nil?
			File.open("top_ssl.txt", 'a') { |file| file.write("#{s}:#{site}\n") }
		end
		count += 1
	rescue => e
		puts e
	end

end