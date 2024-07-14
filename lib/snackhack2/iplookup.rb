# frozen_string_literal: true

module Snackhack2
  class IpLookup
    def initialize(site)
      @site = site
    end

    def run
      get_ip
      nslookup
    end

    def get_ip
      ips = []
      ip = `ping -c 2 #{@site.gsub("https://", "")}`.lines
      ip.each do |l|
        new_ip = l.match(/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/)
        ips << new_ip.to_s unless ips.include?(new_ip)
      end
      puts "IP via ping: #{ips.shift}\n\n\n\n"
    end

    def nslookup
      ns = `nslookup #{@site.gsub("https://", "")}`.lines
      ns.each do |ip|
        puts ip if ip.include?('Address')
      end
    end
  end
end
