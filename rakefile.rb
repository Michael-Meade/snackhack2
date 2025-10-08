# frozen_string_literal: true

require './lib/snackHack2'
# require "snackhack2"
namespace 'gems' do
  desc 'Building gem, Push gem, Install Gem'
  task :all do
    require 'colorize'
    gemfile = Dir.glob('*.gem').each { |f| }.shift
    if !gemfile.nil?
      if File.exist?(gemfile)
        puts "Deleting #{gemfile}...\n".red
        File.delete(gemfile)
        puts "Building gem...\n".red
        `gem build snackhack2.gemspec`
        puts "Pushing Gem...\n".red
        begin
          sh "gem push #{Dir.glob('*.gem').each { |f| }.shift}"
        rescue StandardError
          puts "ERROR in Pushing...\n".red
        end
        puts "[+] Installing gem...\n"
        sh "gem install #{Dir.glob('*.gem').each { |f| }.shift}"
      end
    else
      puts 'No gem file found...'
    end
  rescue StandardError => e
    puts e
  end
  desc 'Push the gem.'
  task :push do
    require 'colorize'
    gemfile = Dir.glob('*.gem').each { |f| }.shift
    unless gemfile.nil?
      puts "Pushing Gem...\n".red
      begin
        sh "gem push #{gemfile}"
      rescue StandardError
        puts "ERROR in pushing gem...\n".red
      end
    end
  end
  desc 'Build the gem.'
  task :build do
    gemspec = Dir.glob('*.gemspec').each { |f| }.shift
    if !gemspec.nil?
      puts "Building gemspec...\n"
      sh "gem build #{gemspec}"
    else
      puts "NO gemspec found...\n"
    end
  end
  desc 'Install the Gem.'
  task :install do
    sh "gem install #{Dir.glob('*.gem').each { |f| }.shift}"
  end
end
namespace 'snackhack' do
    status = true
    desc 'Testing all the commands.'
    task :all do
      puts "\n\n[+] Testing Port scan random IP scan...\n"
      tcp = Snackhack2::PortScan.new
      tcp.count = 100
      tcp.mass_scan
      puts "[+] Testing Localhost port scan...\n"
      tcp.ip = '127.0.0.1'
      tcp.run

      puts "\n\n[+] Testing IP lookup...\n"
      ip = Snackhack2::IpLookup.new
      ip.site = 'https://google.com'
      ip.run
      puts "\n\n[+] Testing IP lookup socket...\n"
      ip.socket

      puts "\n\n[+] Testing Wordpress...\n"
      wp = Snackhack2::WordPress.new
      wp.site = 'https://kinsta.com'
      wp.run
      puts "\n\n[+] Testing Wordpress Users...\n"
      wp.users
      puts "\n\n[+] Testing Wordpress Content Uploads...\n"
      wp.wp_content_uploads

      puts "\n\n[+] Testing ReverseShell...\n"
      rs = Snackhack2::ReverseShell.new
      rs.ip   = '127.0.0.1'
      rs.port = '99'
      puts "\n\n[+] Testing ReverseShell nc...\n"
      rs.nc
      puts "\n\n[+] Testing ReverseShell Version2...\n"
      rs.ncat
      puts "\n\n[+] Testing ReverseShell ncat...\n"
      #rs.bash
      puts "\n\n[+] Testing ReverseShell bash...\n"

      puts "\n\n[+] Testing Google Google Analytics...\n"
      ga = Snackhack2::GoogleAnalytics.new
      ga.site = 'https://g-form.com'
      ga.run

      puts "\n\n[+] Testing Website Meta Data...\n"
      me = Snackhack2::WebsiteMeta.new
      me.site = 'https://kinsta.com'
      me.run

      puts "\n\n[+] Testing Phone Number Extractor...\n"
      wp = Snackhack2::PhoneNumber.new
      wp.site = 'https://pastebin.com/PgJuhznU'
      wp.run

      puts "\n\n[+] Testing Subdomains2...\n"
      Snackhack2::Subdomains2.new('https://netflix.com').run

      puts "\n\n[+] Testing Baner Grabber...\n"
      bg = Snackhack2::BannerGrabber.new
      bg.site = "krebsonsecurity.com"
      bg.run
      puts "\n\n[+] Testing Baner Grabber cURL...\n"
      bg.curl
      puts "\n\n[+] Testing Baner Grabber headers...\n"
      bg.headers

      puts "\n\n[+] Testing DNS A Records...\n"
      d = Snackhack2::Dns.new
      d.site = 'utica.edu'
      puts d.a

      puts "\n\n[+] Testing DNS HINFO Records...\n"
      d = Snackhack2::Dns.new
      d.site = 'google.com'
      puts d.hinfo

      puts "\n\n[+] Testing DNS Nameserver Records...\n"
      d = Snackhack2::Dns.new
      d.site = 'krebsonsecurity.com'
      puts d.nameserver

      puts "\n\n[+] Testing DNS MX Records...\n"
      d = Snackhack2::Dns.new
      d.site = 'utica.edu'
      puts d.mx

      puts "\n\n[+] Testing DNS AAAA Records...\n"
      d = Snackhack2::Dns.new
      d.site = 'google.com'
      puts d.aaaa

      puts "\n\n[+] Testing DNS SOA Records...\n"
      d = Snackhack2::Dns.new
      d.site = 'utica.edu'
      puts d.soa

      puts "\n\n[+] Testing Phishing Domains Changing TLDS...\n"
      ct = Snackhack2::PhishingDomains.new
      ct.site = "blog.google.com"
      new_domains = ct.check_domains
      puts new_domains
    end

end

