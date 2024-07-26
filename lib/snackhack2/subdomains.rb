# frozen_string_literal: true

require 'uri'
require 'resolv'
require 'async/http/internet'
module Snackhack2
  class Subdomains
    def initialize(site, wordlist: nil)
      @site     = site
      @wordlist = wordlist
    end

    def site
      @site.gsub("https://", "")
    end

    def wordlist
      File.join(__dir__, 'lists', 'subdomains.txt')
    end

    def run
      File.readlines(wordlist).each do |sd|
        resolv(sd)
      end
    end

    def brute
      found = ""
      File.readlines(wordlist).each do |l|
        s = "#{l.strip}.#{site}"
        begin
          puts File.join("https://", s)
          g = Snackhack2::get(File.join("https://", s))
          if g.code == 200
            found += s + "\n"
          elsif g.code == 300
            found += s + "\n"
          else
            puts "HTTP Code: #{g.code}"
          end
        rescue => e
          puts e
        end
      end
      Snackhack2::file_save(@site, "subdomain_brute", found)
    end

    def resolv(sd)
      # NOTE: this is really slow & multi thread does not work
      # due to resolv
      active = []
      subdomains = []
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{sd}.#{@site}", Resolv::DNS::Resource::IN::A
        unless ress.map(&:address).empty?
          address = ress.map(&:address)
          unless active.include?(address)
            active << address
            subdomains << "#{sd}.#{@site}" unless subdomains.include?(sd)
          end
        end
      end
      host = URI.parse(@site).host
      File.open("#{host}_subdomains.txt", 'w+') { |file| file.write(subdomains.join("\n")) }
      File.open("#{host}_ips.txt", 'w+') { |file| file.write(active.join("\n")) }
    end
  end
end
