require_relative '../lib/snackHack2'
ga = Snackhack2::GoogleAnalytics.new
File.readlines("top-1000000-domains.txt").each do |site|
	site = site.strip
	ga.site = "https://#{site}"
	begin
		g = ga.run.shift
	rescue
	end
	unless g.eql?(nil)
		unless g.include?("[+] No Google Analytics found :(")
			p g
			puts site

			File.open("top_gas.txt", 'a') { |file| file.write("#{g}:#{site}\n") }
		end
	end
end