require './lib/snackHack2'
bg = Snackhack2::BannerGrabber.new
bg.site = "https://hackex.net"

headers = bg.detect_header(return_status: true) 
headers.each do |k,v|
	v.each do |h|
		puts h
	end
end