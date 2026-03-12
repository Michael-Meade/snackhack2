require_relative '../lib/snackHack2'

wp = Snackhack2::BannerGrabber.new



ww = Snackhack2::WordPress.new


s = ["https://www.sccfd.org", "https://www.caicorp.com", "https://michaelmeade.org"]
puts "\n\n<---------------------------------------->\n\n"
s.each do |ss|
	ww.site = ss
	ww.find_plugins
	puts ww.site
	puts "\n\n<---------------------------------------->\n\n"
end


