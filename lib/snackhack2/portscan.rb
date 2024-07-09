# frozen_string_literal: true

require 'packetfu'
module Snackhack2
  class PortScan
    def initialize(ip)
      @ip = ip
    end

    def run
      threads = []
      ports = [*1..1000]
      ports.each { |i| threads << Thread.new { tcp(i) } }
      threads.each(&:join)
    end

    def tcp(i)
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

      open_ports.each do |port|
        puts "#{port} is open"
      end
    end
  end
end
