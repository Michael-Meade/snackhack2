# frozen_string_literal: true

require 'packetfu'
module Snackhack2
  class PortScan
    attr_accessor :display
    def initialize(ip, display: true)
      @ip = ip
      @display = display
    end

    def run
      threads = []
      ports = [*1..1000]
      ports.each { |i| threads << Thread.new { tcp(i) } }
      threads.each(&:join)
    end

    def tcp(i)
      ip = @ip
      open_ports = []
      begin
        Timeout.timeout(1) do
          s = TCPSocket.new(@ip, i)
          s.close
          open_ports << i
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          return false
        end
      rescue Timeout::Error
      end
      return if open_ports.empty?
      if @display
        open_ports.each do |port|
          puts "#{port} is open"
        end
      end
    File.open("#{ip}_port_scan.txt", 'a') { |file| file.write(open_ports.shift.to_s+ "\n") }
    end
  end
end
