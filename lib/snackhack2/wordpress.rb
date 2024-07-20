# frozen_string_literal: true

require 'json'
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
      wp_log
    end

    def file_site
      @site = @site.gsub('https://', '')
    end

    def users
      found_users = ''
      begin
        users = Snackhack2::get(File.join(@site, "wp-login", "wp", "users")).body
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
      login2 = Snackhack2::get(@site.to_s)
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
    def wp_log
    	wplog_score = 0
    	wp = [ '\wp-content\plugins', 'PHP Notice', 'wp-cron.php', '/var/www/html', 'Yoast\WP\SEO', 'wordpress-seo' ]
    	log = Snackhack2::get(File.join(@site, "/wp-content/debug.log"))
    	if log.code == 200
    		puts "[+] #{File.join(@site, "/wp-content/debug.log")} is giving status 200. Now double checking...\n\n\n"
    		wp.each do |e|
    			if log.body.include?(e)
    				wplog_score += 10
    			end
    		end
    	end
    puts "WordPress Log score: #{wplog_score}..."
    end
    def wp_plugin
    	wp_plugin_score = 0
    	wp = [ 'Index of', 'Name', 'Last modified', 'Size', 'Parent Directory', '/wp-content/plugins' ]
    	plug = Snackhack2::get(File.join(@site, '/wp-content/plugins/'))
    	if plug.code == 200
    		puts "[+] Looks like #{File.join(@site, '/wp-content/plugins/')} is giving status 200. Checking to make sure...\n\n\n"
    		wp.each do |e|
    			if plug.body.include?(e)
    				wp_plugin_score += 10
    			end
    		end
    	end
    puts "[+] WordPress Plugin Score: #{wp_plugin_score}"
    end
  end
end
