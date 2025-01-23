require 'resolv'
module Snackhack2
  class Dns
    attr_accessor :site
    def initialize
      @site = site
    end
    def nameserver
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{@site}", Resolv::DNS::Resource::IN::NS
        ress.each do |l|
          puts l.name.to_s
        end
      end
    end
    def soa
      soa = []
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{@site}", Resolv::DNS::Resource::IN::SOA
        ress.each do |l|
          soa << l.rname
          soa << l.mname
          soa << l.ttl
        end
        puts soa.join("\n")
      end
    end
    def txt
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{@site}", Resolv::DNS::Resource::IN::TXT
        ress.each do |l|
          puts l.strings.to_s
        end
      end
    end
    def mx
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{@site}", Resolv::DNS::Resource::IN::MX
        ress.each do |l|
          puts l.exchange.to_s
        end
      end
    end
  end
end