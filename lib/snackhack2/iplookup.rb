# frozen_string_literal: true
require 'socket'
require 'colorize'
module Snackhack2
  class IpLookup
    attr_accessor :site
    def initialize(site, file_save: false)
      @file_save = file_save
      @site = site
    end

    def run
      get_ip
      nslookup
      socket
    end

    def get_ip
      ips = []
      ip = `ping -c 2 #{@site.gsub('https://', '')}`.lines
      ip.each do |l|
        new_ip = l.match(/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/)
        if !new_ip.to_s.empty?
          ips << new_ip.to_s unless ips.include?(new_ip)
        end
      end
    ips
    end

    def nslookup
      ips = []
      ns = `nslookup #{@site.gsub('https://', '')}`.lines
      ns.each do |ip|
        new_ip = ip.gsub("Address: ", "").strip if ip.include?('Address')
        if !ips.include?(new_ip)
          if !new_ip.nil?
            p new_ip.split("Addresses:  ")[1].to_s
            ips << new_ip.split("Addresses:  ")[1].to_s
          end
        end
      end
      
      if @file_save 
        Snackhack2::file_save(@site, "ip_lookup", ips.to_a.drop(1).join("\n"))
      else
        ips
      end
      
    end

    def socket
      puts IPSocket::getaddress(@site.gsub("https://", ""))
    end
  end
end
