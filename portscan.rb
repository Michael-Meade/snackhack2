# frozen_string_literal: true

require './lib/snackHack2'

256.times do |i|
  puts "167.71.98.#{i}"
  tcp = Snackhack2::PortScan.new
  tcp.ip = "167.71.98.#{i}"
  tcp.run
  print("\n\n")
end
tcp.delete = true
tcp.ports_extractor('22')
