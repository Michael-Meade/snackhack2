# frozen_string_literal: true

require 'httparty'
module Snackhack2
  class WordPress
    def initialize(site)
      @site = site
    end

    def run
      wp_login
    end

    def wp_login
      percent = 0
      ## todo: maybe add Bayes Theorem to detect wp
      wp = ['wp-includes', 'wp-admin', 'Powered by WordPress', 'wp-login.php', 'yoast.com/wordpress/plugins/seo/',
            'wordpress-login-url.jpg', 'wp-content/themes/']
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
