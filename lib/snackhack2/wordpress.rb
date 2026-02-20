# frozen_string_literal: true

require 'nokogiri'
require 'json'
module Snackhack2
  class WordPress
    attr_accessor :save_file, :site

    def initialize(save_file: true)
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
        users = Snackhack2.get(File.join(@site, 'wp-json', 'wp', 'v2', 'users')).body
        json = JSON.parse(users)
        json.each do |k|
          found_users += "#{k['name']}\n"
        end
      rescue StandardError
        puts "[+] users not found\n\n\n"
      end

      return if found_users.empty?

      if @save_file
        Snackhack2.file_save(@site, 'users', found_users)
      else
        puts found_users
      end
    end

    def wp_content_uploads
      s = Snackhack2.get(File.join(@site, '/wp-content/uploads/'))
      return unless s.code == 200
      return unless s.body.include?('Index of')

      puts "[+] #{File.join(@site, '/wp-content/uploads/')} is valid...\n\n\n"
    end

    def wp_login
      # detects if the site is using wordpress
      percent = 0
      ## todo: maybe add Bayes Theorem to detect wp
      wp = ['wp-includes', 'wp-admin', 'Powered by WordPress', 'wp-login.php', 'yoast.com/wordpress/plugins/seo/',
            'wordpress-login-url.jpg', 'wp-content/themes/', 'wp-json']
      login = Snackhack2.get(File.join(@site, 'wp-login.php'))
      if login.code == 200
        wp.each do |path|
          percent += 10 if login.body.include?(path)
        end
      end
      login2 = Snackhack2.get(@site.to_s)
      wp.each do |path|
        percent += 10 if login2.body.include?(path)
      end
      puts "Wordpress Points: #{percent}"
    end

    def yoast_seo
      # checks to see if the wordpress site
      # uses the yoast seo plugin
      ys = Snackhack2.get(@site)
      if ys.code.to_i.eql?(200)
        if ys.body.match?("Yoast")
          yoast_version = ys.body.split('<!-- This site is optimized with the Yoast SEO Premium plugin')[1].split(' -->')[0]
          ['This site is optimized with the Yoast SEO plugin', 'This site is optimized with the Yoast SEO Premium plugin'].each do |site|
            puts "#{ys.body.scan(/#{site}/).shift} with version #{yoast_version}" unless ys.body.scan(/#{site}/).shift.nil?
          end
        end
      end
    end

    def all_in_one_seo
      alios = Snackhack2.get(@site)
      return unless alios.code == 200
      # scans the body for the text `All in One SEO Pro`
      return unless alios.body.scan(/(All in One SEO Pro\s\d.\d.\d)/)

      puts "Site is using the plugin: #{alios.body.match(/(All in One SEO Pro\s\d.\d.\d)/)}"
    end

    def wp_log
      wplog_score = 0
      wp = ['\wp-content\plugins', 'PHP Notice', 'wp-cron.php', '/var/www/html', 'Yoast\WP\SEO', 'wordpress-seo']
      log = Snackhack2.get(File.join(@site, '/wp-content/debug.log'))
      if log.code == 200
        puts "[+] #{File.join(@site, '/wp-content/debug.log')} is giving status 200. Now double checking...\n\n\n"
        wp.each do |e|
          wplog_score += 10 if log.body.include?(e)
        end
      end
      puts "WordPress Log score: #{wplog_score}...\n\n\n"
    end

    def wp_plugin
      wp_plugin_score = 0
      # text in which it will search for
      wp = ['Index of', 'Name', 'Last modified', 'Size', 'Parent Directory', '/wp-content/plugins']
      plug = Snackhack2.get(File.join(@site, '/wp-content/plugins/'))
      if plug.code == 200
        puts "[+] Looks like #{File.join(@site,
                                         '/wp-content/plugins/')} is giving status 200. Checking to make sure...\n\n\n"
        wp.each do |e|
          wp_plugin_score += 10 if plug.body.include?(e)
        end
      end
      puts "[+] WordPress Plugin Score: #{wp_plugin_score}"
    end
  end
end
