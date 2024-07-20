# frozen_string_literal: true

require 'json'
require 'httparty'
module Snackhack2
  class WordPress
    attr_accessor :save_file, :site

    def initialize(site, save_file: true)
      @site = site
      @save_file = save_file
    end

    def run
      wp_login
      yoast_seo
      users
      wp_content_uploads
      all_in_one_seo
    end

    def file_site
      @site = @site.gsub('https://', '')
    end

    def users
      found_users = ''
      begin

        users = Snackhack2::get(File.join(@site, "wp-login", "wp","users")).body
        json = JSON.parse(users)
        json.each do |k|
          found_users += "#{k['name']}\n"
        end
      rescue StandardError => e
      	puts e
        puts '[+] users not found'
      end
      if @save_file
      	Snackhack2::file_save(@site, "users", found_users)
      else
        puts found_users
      end
    end

    def wp_content_uploads
      s = Snackhack2::get(File.join(@site, '/wp-content/uploads/'))
      if s.code == 200
      	if s.body.include?('Index of')
      		puts "[+] #{File.join(@site, '/wp-content/uploads/')} is valid..."
      	end
      end
    end

    def wp_login
      percent = 0
      ## todo: maybe add Bayes Theorem to detect wp
      wp = ['wp-includes', 'wp-admin', 'Powered by WordPress', 'wp-login.php', 'yoast.com/wordpress/plugins/seo/',
            'wordpress-login-url.jpg', 'wp-content/themes/', 'wp-json']
      login = Snackhack2::get(File.join(@site, "wp-login.php"))
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

    def yoast_seo
    	ys = Snackhack2::get(@site)
    	if ys.code == 200
    		if ys.body.match(/ This site is optimized with the Yoast SEO plugin\s.\d\d.\d/)
    			puts "#{ys.body.match(/ This site is optimized with the Yoast SEO plugin\s.\d\d.\d/)}"
    		end
    	end
    end
    def all_in_one_seo
    	alios = Snackhack2::get(@site)
    	if alios.code == 200
    		if alios.body.scan(/(All in One SEO Pro\s\d.\d.\d)/)
    			puts "Site is using the plugin: #{alios.body.match(/(All in One SEO Pro\s\d.\d.\d)/)}"
    		end
    	end
    end
  end
end
