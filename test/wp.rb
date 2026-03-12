require_relative '../lib/snackHack2'

wp = Snackhack2::BannerGrabber.new



ww = Snackhack2::WordPress.new


s = ["https://www.sccfd.org", "https://www.caicorp.com", "https://michaelmeade.org"]

s.each do |ss|
	ww.site = ss
	ww.yoast_seo(print_version: true)
	puts "<--------------------------------------->"
	puts ww.yoast_seo
end


