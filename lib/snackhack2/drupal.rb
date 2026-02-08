# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
module Snackhack2
  class Drupal
    attr_accessor :site

    def initialize
      @site = site
    end

    def all
      drupal_score
      user_brute
    end

    def drupal_score
      drupal_score = 0
      d = Snackhack2.get(@site)
      if d.code == 200
        d.headers.each do |k,v|
          drupal_score += 10 if k.downcase.include?('drupal')
          drupal_score += 10 if v.downcase.include?('drupal')
        end
      end
      
      doc = Nokogiri::HTML(URI.open(@site))
      # uses xpath to extra the data stored in the meta tags
      posts = doc.xpath('//meta')
      posts.each do |l|
        # display the drupal version and other info
        puts "\n\n[+] Drupal Version: #{l.attributes['content']}\n" if l.attributes['content'].to_s.include?('Drupal')
      end
      puts "\nDrupal Score: #{drupal_score}\n"
    end

    def user_brute
      # enumerate the users by looping 0 to 1000
      (1..1000).each do |user|
        u = Snackhack2.get(File.join(@site, 'user', user.to_s)).body
        if u.include?('Page not found')
          puts "\nUser count: #{user - 1}\n"
          break
        end
      end
    end
  end
end
