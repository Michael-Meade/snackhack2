require 'snackhack2'

tcp = Snackhack2::PortScan.new
tcp.count = 100
tcp.mass_scan
