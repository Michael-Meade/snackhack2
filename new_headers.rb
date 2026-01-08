require './lib/snackHack2'
bg = Snackhack2::BannerGrabber.new
bg.site = "100.33.33.33"
bg.get_tcp_info
=begin
headers = bg.detect_header(return_status: true) 
headers.each do |k,v|
	v.each do |h|
		puts h
	end
end
=end