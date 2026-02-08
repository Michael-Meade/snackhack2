# frozen_string_literal: true

require 'async/http/internet'
module Snackhack2
  class Subdomains2
    def initialize(site)
      @site = site
      @urls = []
    end

    def wordlist
      File.join(__dir__, 'lists', 'subdomains.txt')
    end

    def save
      Snackhack2.file_save(@site, 'subdomain_brute2', @urls.join("\n"))
    end

    def run
      File.readlines(wordlist).each do |a|
        # removes `https://` from the instance variable
        # `@site`. Adds the subdomain from the file to test if it is valid
        url = "https://#{a.strip}.#{@site.gsub('https://', '')}"
        fetch(url)
        puts url
      end
      save
    end

    def fetch(url)
      Sync do |task|
        task.with_timeout(2) do
          internet = Async::HTTP::Internet.new
          m = internet.get(url, { 'user-agent' => Snackhack2::UA })
          # only adds it to the @url instance variable if
          # it returns a status code of `200` OR `301`
          @urls << url if (m.status == 200) || (m.status == 301)
          m.read
        end
      end
    rescue StandardError => e
      puts e
    end
  end
end
