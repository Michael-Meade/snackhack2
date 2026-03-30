require_relative '../lib/snackHack2'
def perform_scan
	sl = Snackhack2::ScanLocal.new
	sl.ip_range = "192.168.0.1/24"
	file = sl.ping_scan
	sl.read_file = file
	return file
end

def extract_hostname(line)
	line = line.split("(")[1].split(")")[0]
	if line.empty?
		return "none"
	else
		return line
	end
end
#file = perform_scan
found = {}
file = "grepable_ping_scan_192.168.0.1_24.txt"
File.readlines(file).each do |line|
	line = line.chomp
	if line.include?("Status: Up")
		host = extract_hostname(line)
		ip 	 =	line.match(/(\b25[0-5]|\b2[0-4][0-9]|\b[01]?[0-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)){3}/).to_s
		unless found.has_key?(ip)
			found[ip] = host
		end
	end
end
p found