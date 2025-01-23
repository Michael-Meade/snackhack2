require './lib/snackHack2'
  #require "snackhack2"
namespace "gems" do
  desc "Building gem, Push gem, Install Gem"
  task :all do
    begin
      require "colorize"
      gemfile = Dir.glob("*.gem").each { |f| f }.shift
      if !gemfile.nil?
        if File.exist?(gemfile)
          puts "Deleting #{gemfile}...\n".red
          File.delete(gemfile)
          puts "Building gem...\n".red
          %x(gem build snackhack2.gemspec)
          puts "Pushing Gem...\n".red
          begin
            sh "gem push #{Dir.glob("*.gem").each { |f| f }.shift}"
          rescue
            puts "ERROR in Pushing...\n".red
          end
          puts "[+] Installing gem...\n"
          sh "gem install #{Dir.glob("*.gem").each { |f| f }.shift}"
        end
      else
        puts "No gem file found..."
      end
    rescue => e
      puts e
    end
  end
  desc "Push the gem."
  task :push do
    require "colorize"
    gemfile = Dir.glob("*.gem").each { |f| f }.shift
    if !gemfile.nil?
      puts "Pushing Gem...\n".red
      begin
        sh "gem push #{gemfile}"
      rescue
        puts "ERROR in pushing gem...\n".red
      end
    end
  end
  desc "Build the gem."
  task :build do
    gemspec = Dir.glob("*.gemspec").each { |f| f }.shift
    if !gemspec.nil?
      puts "Building gemspec...\n"
      sh "gem build #{gemspec}"
    else
      puts "NO gemspec found...\n"
    end
  end
  desc "Install the Gem."
  task :install do
    sh "gem install #{Dir.glob("*.gem").each { |f| f }.shift}"
  end
end
namespace "snackhack" do
  desc "Testing all the commands."
  task :all do
    puts "\n\n[+] Testing Port scan random IP scan...\n"
    tcp = Snackhack2::PortScan.new
    tcp.count = 100
    tcp.mass_scan
    puts "[+] Testing Localhost port scan...\n"
    tcp.ip = "127.0.0.1"
    tcp.run

    puts "\n\n[+] Testing IP lookup...\n"
    ip = Snackhack2::IpLookup.new
    ip.site = "https://google.com"
    ip.run
    puts "\n\n[+] Testing IP lookup socket...\n"
    ip.socket

    puts "\n\n[+] Testing Wordpress...\n"
    wp = Snackhack2::WordPress.new
    wp.site = "https://kinsta.com"
    wp.run
    puts "\n\n[+] Testing Wordpress Users...\n"
    wp.users
    puts "\n\n[+] Testing Wordpress Content Uploads...\n"
    wp.wp_content_uploads

    puts "\n\n[+] Testing ReverseShell...\n"
    rs = Snackhack2::ReverseShell.new
    rs.ip   = "127.0.0.1"
    rs.port = "99"
    rs.run
    puts "\n\n[+] Testing ReverseShell Version2...\n"
    rs.version2

    puts "\n\n[+] Testing Google Google Analytics...\n"
    ga = Snackhack2::GoogleAnalytics.new
    ga.site = "https://g-form.com"
    ga.run

    puts "\n\n[+] Testing Website Meta Data...\n"
    me = Snackhack2::WebsiteMeta.new
    me.site = 'https://kinsta.com'
    me.run

    puts "\n\n[+] Testing Phone Number Extractor...\n"  
    wp = Snackhack2::PhoneNumber.new
    wp.site = "https://pastebin.com/PgJuhznU"
    wp.run

    puts "\n\n[+] Testing Subdomains2...\n"
    Snackhack2::Subdomains2.new("https://netflix.com").run

    puts "\n\n[+] Testing Baner Grabber...\n"
    bg = Snackhack2::BannerGrabber.new("http://95.142.29.235")
    bg.run
    puts "\n\n[+] Testing Baner Grabber cURL...\n"
    bg.curl
    puts "\n\n[+] Testing Baner Grabber headers...\n"
    bg.headers 


  end
  desc "Find all comments on a site."
  task :comments do
    ph = Snackhack2::Comments.new
    ph.site = "https://krebsonsecurity.com"
    ph.run
  end 
  desc "List users, in Linux and Windows."
  task :list_users do 
    lu = Snackhack2::ListUsers.new
    lu.auto
  end
  desc "Testing Reverse Shell."
  task :reverseshell do
    rs = Snackhack2::ReverseShell.new
    rs.ip   = "127.0.0.1"
    rs.port = "99"
    puts "\n\n[+] Testing ReverseShell ncat...\n"
    rs.ncat
    rs.nc
  end
  desc "Testing Google Analytics."
  task :ga do
    ga = Snackhack2::GoogleAnalytics.new
    ga.site = "https://hackex.net"
    ga.run
  end
  desc "Test bannergrabber."
  task :bannergrabber do
    puts "\n\n[+] Testng Baner Grabber...\n"
    bg = Snackhack2::BannerGrabber.new("http://95.142.29.235")
    bg.run
    puts "\n\n[+] Testng Baner Grabber cURL...\n"
    bg.curl
    puts "\n\n[+] Testng Baner Grabber headers...\n"
    bg.headers 
  end
  desc "Testing Robots.txt"
  task :robots do
    robots = Snackhack2::Robots.new("https://krebsonsecurity.com")
    puts robots.run
  end
  desc "Testing Drupal"
  task :drupal do 
    d   = Snackhack2::Drupal.new
    d.site = "https://physiologycore.umn.edu/"
    d.all
  end
  desc "DNS MX Records"
  task :mx do
    d   = Snackhack2::Dns.new
    d.site = "utica.edu"
    d.mx
  end
end
