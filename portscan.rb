require './lib/snackHack2'

for i in 0..255
  puts "167.71.98.#{i}"
  tcp = Snackhack2::PortScan.new
  tcp.ip = "167.71.98.#{i}"
  tcp.run
  i += 1
  print("\n\n")
end
tcp.delete = true
tcp.ports_extractor("22")
