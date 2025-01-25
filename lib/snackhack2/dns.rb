require 'resolv'
module Snackhack2
  class Dns
    attr_accessor :site
    def initialize
      @site = site
    end
    def all_dns
      nameserver
      soa
      txt
      aaaa
      mx
    end
    def a
      a = []
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{@site}", Resolv::DNS::Resource::IN::A
        ress.each do |l|
          a << l.address.to_s
        end
      end
    a
    end
    def nameserver
      ns = []
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{@site}", Resolv::DNS::Resource::IN::NS
        ress.each do |l|
        ns << l.name.to_s
        end
      end
    ns
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
      end
    soa
    end
    def txt
      txt = []
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{@site}", Resolv::DNS::Resource::IN::TXT
        ress.each do |l|
          txt << l.strings.to_s
        end
      end
    txt
    end
    def aaaa
      aaaa = []
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{@site}", Resolv::DNS::Resource::IN::AAAA
        ress.each do |l|
          aaaa << l.address
        end
      end
    aaaa
    end
    def hinfo
      hinfo = []
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{@site}", Resolv::DNS::Resource::IN::HINFO
        ress.each do |l|
          hinfo << l.exchange.to_s
        end
      end
    hinfo
    end
    def mx
      mx = []
      Resolv::DNS.open do |dns|
        ress = dns.getresources "#{@site}", Resolv::DNS::Resource::IN::MX
        ress.each do |l|
          mx << l.exchange.to_s
        end
      end
    mx
    end
  end
end