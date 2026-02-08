# frozen_string_literal: true

require 'socket'
require 'colorize'
module Snackhack2
  class IpLookup
    attr_accessor :site

    def initialize(file_save: false)
      @file_save = file_save
      @site = site
    end

    def run
      get_ip
      nslookup
      socket
    end

    def get_ip
      # uses ping commad to get IP of the host
      ips = []
      # Removes 'https://' from @site
      ip = `ping -c 2 #{@site.gsub('https://', '')}`.lines
      ip.each do |l|
        # uses a regex to find IPs
        new_ip = l.match(/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/)
        # adds the new_ip to the `ips` array. if it is NOT empty or already in the array
        ips << new_ip.to_s if unless new_ip.to_s.empty? && unless ips.include?(new_ip)
      end
      ips
    end

    def nslookup
      # Uses the nslookup command to extract the @site IP
      ips = []
      # removes 'https://' from the command and execute 
      # the command and turn the results into array
      ns = `nslookup #{@site.gsub('https://', '')}`.lines
      ns.each do |ip|
        new_ip = ip.gsub('Address: ', '').strip if ip.include?('Address')
        # if the IP is NOT already in the array AND the `new_ip` variable is not nil
        # it will add to the ip to the `ips` array
        unless ips.include?(new_ip) && unless new_ip.nil?
          
          ips << new_ip.split('Addresses:  ')[1].to_s
        end
      end
      # if @file_save set to true it will save the contents of `ips` to a file.
      if @file_save
        Snackhack2.file_save(@site, 'ip_lookup', ips.to_a.drop(1).join("\n"))
      else
        # if @file_save is set to false it will return the array ips.
        ips
      end
    end

    def socket
      # Uses IPSocket to get the IP.
      # removes 'https://' from the instance variable
      puts IPSocket.getaddress(@site.gsub('https://', ''))
    end
  end
end
