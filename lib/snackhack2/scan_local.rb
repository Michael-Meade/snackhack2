# frozen_string_literal: true

require 'nmap/command'
module Snackhack2
  class ScanLocal
    attr_accessor :save_file, :ip_range
    # some notes that this will only work on Linux for now.
    def initialize(save_file: true, output: "scan.xml")
      @ip_range = ip_range
      @save_file = save_file
      @output    = output
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
    def list_scan
      if check_nmap?
        Nmap::Command.sudo do |nmap|
          nmap.list           = true
          nmap.output_xml     = "list_#{@output}"
          nmap.verbose        = true
          nmap.targets = @ip_range
        end
      end
    end
    def nmap_sn
      # ping scan
      if check_nmap?
        Nmap::Command.sudo do |nmap|
          nmap.ping           = true
          nmap.output_xml     = "ping_#{@output}"
          nmap.verbose        = true
          nmap.targets = @ip_range
        end
      end
    end
  end
end
