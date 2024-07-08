module Snackhack2
	class Robots
		def initialize(site, save_file: true)
			@site = site
			@http = HTTParty.get("#{@site}/robots.txt")
			@save_file = save_file
		end
		def save_file
			@save_file
		end
		def run
			save_txt_file = ""
			allow    = allow_robots 
			disallow = disallow_robots
			if @save_file
				save_txt_file += "ALLOW:\n\n"
				if !allow.empty?
					allow.each do |list|
						save_txt_file  += list
					end
				end
				save_txt_file += "DISALLOW:\n\n"
				if !disallow.empty?
					disallow.each do |list|
						save_txt_file += list
					end
				end
			else
				puts allow
				puts disallow
			end

			File.open("#{@site.gsub("https://", "")}_robots.txt", 'w+') { |file| file.write(save_txt_file) }
		end
		def allow_robots
			allow_dir = []
			if @http.code == 200
				body = @http.body.lines
				body.each do |l|
					if l.match(/Allow:/)
						allow_dir << l.split("Allow: ")[1]
					end
				end
			else
				puts "[+] Not giving code 200.\n"
			end
			open_links = []
			allow_dir.each do |path|
				link = HTTParty.get("#{@site}#{path.strip}")
				if link.code == 200
					valid_links = "#{@site}#{path}"
					open_links << valid_links
				end
			end
		open_links
		end
		def disallow_robots
			disallow_dir = []
			if @http.code == 200
				body = @http.body.lines
				body.each do |l|
					if l.match(/Disallow:/)
						disallow_dir << l.split("Disallow: ")[1]
					end
				end
			else
				puts "[+] Not giving code 200.\n"
			end
			open_links = []
			disallow_dir.each do |path|
				begin
					link = HTTParty.get("#{@site}#{path.strip}")
					if link.code == 200
						valid_links = "#{@site}#{path}"
						open_links << valid_links
					end
				rescue
				end
			end
			open_links
		end
	end
end