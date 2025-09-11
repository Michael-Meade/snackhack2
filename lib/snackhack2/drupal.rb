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
        d.headers.each do |k|
          drupal_score += 10 if k.include?('drupal')
        end
      end
      d.headers.each do |v|
        drupal_score += 10 if v.include?('drupal')
      end
      doc = Nokogiri::HTML(URI.open(@site))
      posts = doc.xpath('//meta')
      posts.each do |l|
        puts "\n\n[+] Drupal Version: #{l.attributes['content']}\n" if l.attributes['content'].to_s.include?('Drupal')
      end
      puts "\nDrupal Score: #{drupal_score}\n"
    end

    def user_brute
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
