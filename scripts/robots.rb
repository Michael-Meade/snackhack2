require_relative '../lib/snackHack2'
site = "https://michaelmeade.org"
r = Snackhack2::Robots.new(site)

r.disallow_robots.each do |da|
  puts da
end
