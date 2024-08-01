# frozen_string_literal: true

require 'uri'
require 'httparty'
require_relative 'snackhack2/version'
require_relative 'snackhack2/bannergrabber'
require_relative 'snackhack2/wordpress'
require_relative 'snackhack2/portscan'
require_relative 'snackhack2/iplookup'
require_relative 'snackhack2/robots'
require_relative 'snackhack2/subdomains'
require_relative 'snackhack2/sshbrute'
require_relative 'snackhack2/website_meta'
require_relative 'snackhack2/google_analytics'
require_relative 'snackhack2/cryptoextractor'
require_relative 'snackhack2/website_links'
require_relative 'snackhack2/webserver_log_cleaner'
require_relative 'snackhack2/wpForo_Forum'
require_relative 'snackhack2/WP_Symposium'
require_relative 'snackhack2/phone_number'
require_relative 'snackhack2/emails'
require_relative 'snackhack2/drupal'
require_relative 'snackhack2/Honeywell_PM43'
require_relative 'snackhack2/sitemap'
require_relative 'snackhack2/tomcat'
require_relative 'snackhack2/subdomains2'
require_relative 'snackhack2/reverse_shell'
module Snackhack2
  UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36"
  def self.read_serverversion
    files = Dir['*.txt']
    files.each do |f|
      read = File.read(f)
      puts "#{f.split('_')[0]}: #{read}"
    end
  end

  def self.clean_serverversion
    #  this wil remove all files that have '_serverversion'
    #  in the file name
    Dir['*.txt'].each do |file|
      if file.include?('_serverversion')
        puts "[+] deleting #{file}..."
        File.delete(file)
      end
    end
  end

  def self.file_save(site, type, content)
    hostname = URI.parse(site).host
    File.open("#{hostname}_#{type}.txt", 'w+') { |file| file.write(content) }
    puts "[+] Saving file to #{hostname}_#{type}.txt..."
  end

  def self.get(site)
    HTTParty.get(site, { headers: { "User-Agent" => UA } })
  end
end
