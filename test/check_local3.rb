require_relative '../lib/snackHack2'

sl = Snackhack2::ScanLocal.new
p sl.get_ips_hash("192.168.0.1/24")
