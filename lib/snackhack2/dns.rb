require 'resolv'
module Snackhack2
  class Dns
    attr_accessor :site
    def initialize
      @site = site
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