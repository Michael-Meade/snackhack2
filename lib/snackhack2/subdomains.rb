# frozen_string_literal: true

require 'uri'
require 'resolv'
module Snackhack2
  class Subdomains
    def initialize(site, wordlist: nil)
      @site     = site
      @wordlist = wordlist
    end

    def wordlist
      File.join(__dir__, 'lists', 'subdomains.txt')
    end

    def run
      File.readlines(wordlist).each do |sd|
        resolv(sd)
      end
    end

    def resolv(sd)
      # NOTE: this is really slow & multi thread doesnt work
      # due to resolv
      active = []
      subdomains = []
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{sd}.#{site}", Resolv::DNS::Resource::IN::A
        unless ress.map(&:address).empty?
          address = ress.map(&:address)
          unless active.include?(address)
            active << address
            subdomains << "#{sd}.#{site}" unless subdomains.include?(sd)
          end
        end
      end
      host = URI.parse(@site).host
      File.open("#{host}_subdomains.txt", 'w+') { |file| file.write(subdomains.join("\n")) }
      File.open("#{host}_ips.txt", 'w+') { |file| file.write(active.join("\n")) }
    end
  end
end
