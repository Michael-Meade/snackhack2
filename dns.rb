require './lib/snackHack2'

ps   = Snackhack2::PortScan.new
dns  = Snackhack2::Dns.new
ip   = Snackhack2::IpLookup.new 

ips  = []


dns.site  = "utica.edu"
ns        = dns.nameserver
ns.each do |i|
	ip.site = i
	ips << ip.get_ip.shift
end

ips.each do |ii|
	ps.ip = ii.to_s
	ps.run
end