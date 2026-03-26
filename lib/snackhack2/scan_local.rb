# frozen_string_literal: true

require 'nmap/command'
module Snackhack2
  class ScanLocal
    attr_accessor :save_file, :ip_range, :read_file
    # some notes that this will only work on Linux for now.
    def initialize(save_file: true, output: "scan.xml", read_file: "scan.txt")
      @ip_range = ip_range
      @save_file = save_file
      @output    = output
    end
    def cleaned_ip_range
      return @ip_range.gsub("\/", "_")
    end
    def check_nmap?
      # will return if nmap is installed.
      which = `which nmap`
      if which.nil? || which.empty?
        puts "nmap is not installed"
        return false
      else
        return true
      end
    end
    def output_file(type)
     "#{type}_#{cleaned_ip_range}.txt" 
    end
    def list_scan
      if check_nmap?
        Nmap::Command.sudo do |nmap|
          nmap.list           = true
          nmap.output_xml     = output_file("list_scan") 
          nmap.verbose        = true
          nmap.targets = @ip_range
        end
      end
      return output_file("list_scan")
    end
    def ping_scan
      # ping scan
      if check_nmap?
        Nmap::Command.sudo do |nmap|
          nmap.ping            = true
          nmap.verbose         = true
          nmap.output_grepable = output_file("grepable")
          nmap.targets = @ip_range
        end
      end
    return output_file("grepable")
    end
    def get_up_hosts_from_file
      up_ips = []
      File.foreach(@read_file) do |file|
        if file.include?("Up")
          extract_ip = file.split("()")[0]
          ips = extract_ip.split("Host: ")[1].strip
          up_ips << ips
        end
      end
    return up_ips
    end
  end
end
