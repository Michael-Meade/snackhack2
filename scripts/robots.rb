require_relative '../lib/snackHack2'
site = "https://hackex.net"
r = Snackhack2::Robots.new
r.site = site
r.run

    
r.site = "https://michaelmeade.org"
puts "DISALLOW: "
r.disallow_robots.each do |da|
  puts da
end
