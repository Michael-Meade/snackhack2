require_relative '../lib/snackHack2'
require 'colorize'
def ping_scan
	sl = Snackhack2::ScanLocal.new
	sl.ip_range = "192.168.1.0/24"
	file = sl.ping_scan
	sl.read_file = file
	up = sl.get_up_hosts_from_file
	puts "IPs FOUND: ".green
	up.each do |ip|
		puts ip
	end
end

def list_scan
	sl = Snackhack2::ScanLocal.new
	sl.ip_range = "192.168.1.0/24"
	file = sl.list_scan
	sl.read_file = file
	up = sl.get_up_hosts_from_file
	# Makes sure that there were IPs found during 
	# the list scan. If not it will just 
	# skip printing the found IPs
	unless up.empty?
		puts "IPs FOUND: ".green
		up.each do |ip|
			puts ip
		end
	end
end

ls = list_scan
# checks to see if the list_scan is 
# nil and if it is it will ru the ping_scan
if ls.nil?
	puts "\n\n\n\n\nList Scan failed... None detected. Now performing Ping Scan\n\n\n".red
	ping_scan
end
