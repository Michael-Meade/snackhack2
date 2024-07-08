require 'packetfu'
module Snackhack2
	class PortScan
		def initialize(ip)
			@ip = ip
		end
		def run
			threads = []
			ports = [*1..1000]
			ports.each { |i| threads << Thread.new { tcp(i) }}
			threads.each(&:join)
		end
		def tcp(i)
			open_ports = []
				begin
				    Timeout::timeout(1) do
				      begin
				        s = TCPSocket.new(@ip, i)
				        s.close
				        open_ports << i
				      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
				        return false
				      end
				    end
				rescue Timeout::Error
					
				end
			if !open_ports.empty?
				open_ports.each do |port|
					puts "#{port} is open"
				end
			end
		end
	end
end