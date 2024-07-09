# frozen_string_literal: true

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

    def site
      @site.gsub('https://', '')
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
      File.open("#{@site.gsub('https://', '')}_subdomains.txt", 'w+') { |file| file.write(subdomains.join("\n")) }
      File.open("#{@site.gsub('https://', '')}_ips.txt", 'w+') { |file| file.write(active.join("\n")) }
    end
  end
end
