# frozen_string_literal: true

require 'async'
require 'httparty'
module Snackhack2
  class BypassHTTP
    attr_accessor :site, :wordlist, :bypass

    def initialize
      @site     = site
      @wordlist = File.join(__dir__, 'lists', 'directory-list-2.3-big.txt')
      @bypass   = '//'
    end

    def forward_for
      File.readlines(@wordlist).each do |r|
        r = r.strip
        Async do
          url = File.join(@site, @bypass, r)
          r = HTTParty.get(url, headers: {
                             "X-Forwarded-For": '127.0.0.1'
                           })
          puts url
          puts r.code
          puts "\n"
        end
      end
    end

    def web_request(bypass)
      File.readlines(@wordlist).each do |r|
        r = r.strip
        Async do
          url = File.join(@site, bypass, r)
          r = Snackhack2.get(url)
          puts url
          puts r.code
          puts "\n"
        end
      end
    end

    def basic
      web_request('//')
    end

    def uppercase
      File.readlines(@wordlist).each do |r|
        r = r.strip.gsub(/./) { |s| s.send(%i[upcase downcase].sample) }
        Async do
          url = File.join(@site, r)
          puts url
          r = Snackhack2.get(url)
          puts r.code
          puts "\n"
        end
      end
    end

    def url_encode
      web_request('%2e')
    end

    def dots
      web_request('..;/')
    end
  end
end
