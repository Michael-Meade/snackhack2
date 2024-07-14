# frozen_string_literal: true

require 'uri'
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
module Snackhack2
  def self.read_serverversion
    files = Dir["*.txt"]
    files.each do |f|
      read  = File.read(f)
      puts "#{f.split("_")[0]}: #{read}"
    end
  end
  def self.clean_serverversion
    #  this wil remove all files that have '_serverversion'
    #  in the file name
    Dir["*.txt"].each do |file|
      if file.include?("_serverversion")
        puts "[+] deleting #{file}..."
        File.delete(file)
      end
    end
  end
end
