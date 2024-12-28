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
      d = Snackhack2::get(@site)
      if d.code == 200
        d.headers.each do |k|
          if k.include?("drupal")
            drupal_score += 10
          end
        end
      end
      d.headers.each do |v|
        if v.include?("drupal")
          drupal_score += 10
        end
      end
      doc = Nokogiri::HTML(URI.open(@site))
      posts = doc.xpath('//meta')
      posts.each do |l|
        if l.attributes['content'].to_s.include?("Drupal")
          puts "\n\n[+] Drupal Version: #{l.attributes['content']}\n"
        end
      end
      puts "\nDrupal Score: #{drupal_score}\n"
    end

    def user_brute
      for user in 1..1000 do
        u = Snackhack2::get(File.join(@site, "user", user.to_s)).body
        if u.include?("Page not found")
          puts "\nUser count: #{user - 1}\n"
          break
        end
      end
    end
  end
end
