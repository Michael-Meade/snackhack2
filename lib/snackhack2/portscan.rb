# frozen_string_literal: true

module Snackhack2
  class PortScan
    attr_accessor :display, :ip, :delete, :count

    def initialize(display: true, delete: false, count: 10, terminal_output: false)
      @ip      = ip
      @display = display
      @delete  = delete
      @count   = count
      @terminal_output = terminal_output
    end

    def run
      # runs `tcp` with threads
      threads = []
      # creates all the ports between 1 and 1000
      ports = [*1..1000]
      ports.each { |i| threads << Thread.new { tcp(i) } }
      threads.each(&:join)
    end

    def mass_scan
      # uses the `generate_ips` to generate radom 
      # IPs. then performs the scan
      generate_ips.each do |ips|
        tcp = PortScan.new
        tcp.ip = ips
        tcp.run
      end
    end

    def generate_ips
      # generate a bunch of different Ips to an
      # array named `ips`.
      ips = []
      @count.to_i.times do |_c|
        ips << Array.new(4) { rand(256) }.join('.')
      end
      ips
    end

    def ports_extractor(port)
      # Looks through the files in the folder that 
      # match '_port_scan.txt' which extracts the 
      # ports

      ip = []
      files = Dir['*_port_scan.txt']
      files.each do |f|
        r = File.read(f)
        ip << f.split('_')[0] if r.include?(port)
        File.delete(f) if delete
      end
      File.open("#{port}_scan.txt", 'w+') { |file| file.write(ip.join("\n")) }
    end

    def tcp(i)
      ip = @ip
      open_ports = []
      begin
        Timeout.timeout(1) do
          s = TCPSocket.new(@ip, i)
          s.close
          open_ports << i
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, Errno::ENETUNREACH
          return false
        end
      rescue Timeout::Error
      end
      return if open_ports.empty?

      return unless @display
      # displays the open ports and IPs
      open_ports.each do |port|
        puts "#{ip} - #{port} is open\n"
      end
      File.open("#{ip}_port_scan.txt", 'a') { |file| file.write("#{open_ports.shift}\n") }
    end
  end
end
