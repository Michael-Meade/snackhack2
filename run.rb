
require "./lib/snackHack2"
=begin    
### Banner Grabber

s = Snackhack2::BannerGrabber.new("https://google.com")
s.curl

### Word Press

wp = Snackhack2::WordPress.new("https://google.com")
wp.run

### Port Scan
tcp = Snackhack2::PortScan.new("167.71.98.134")
tcp.run

### Robots

#ip = Snackhack2::Robots.new("https://google.com", save_file: true)
#puts ip.run

#sd = Snackhack2::Subdomains.new("https://ruby-lang.org")

#sd.run
=end
#Snackhack2::SSHBute.new("167.98.80.8").run

wp = Snackhack2::WordPress.new("https://kinsta.com")
wp.run