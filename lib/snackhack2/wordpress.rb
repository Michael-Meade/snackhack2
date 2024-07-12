# frozen_string_literal: true

require 'json'
require 'httparty'
module Snackhack2
  class WordPress
    attr_accessor :save_file

    def initialize(site, save_file: true)
      @site = site
      @save_file = save_file
    end

    def run
      wp_login
    end

    def file_site
      @site = @site.gsub('https://', '')
    end

    def users
      found_users = ''
      begin
        users = HTTParty.get("#{@site}/wp-json/wp/v2/users").body
        json = JSON.parse(users)
        json.each_key do |k|
          found_users += "#{k['name']}\n"
        end
      rescue JSON::ParserError
        puts '[+] users not found'
      end
      if @save_file
        File.open("#{file_site}_users.txt", 'w+') { |file| file.write(found_users) }
      else
        puts found_users
      end
    end

    def wp_login
      percent = 0
      ## todo: maybe add Bayes Theorem to detect wp
      wp = ['wp-includes', 'wp-admin', 'Powered by WordPress', 'wp-login.php', 'yoast.com/wordpress/plugins/seo/',
            'wordpress-login-url.jpg', 'wp-content/themes/', 'wp-json']
      login = HTTParty.get("#{@site}/wp-login.php")
      if login.code == 200
        wp.each do |path|
          percent += 10 if login.body.include?(path)
        end
      end
      login2 = HTTParty.get(@site.to_s)
      wp.each do |path|
        percent += 10 if login2.body.include?(path)
      end
      puts "Wordpress Points: #{percent}"
    end
  end
end
