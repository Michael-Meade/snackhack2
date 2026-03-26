require_relative '../lib/snackHack2'

sl = Snackhack2::ScanLocal.new

sl.ip_range = "192.168.1.0/24"

file = sl.ping_scan


# sl.list_scan

sl.read_file = file
up = sl.get_up_hosts_from_file
up.each do |ip|
	puts ip
end
