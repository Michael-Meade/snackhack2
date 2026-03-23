# frozen_string_literal: true

module Snackhack2
  class Robots
    attr_accessor :port, :site, :save_file, :http
    def initialize(site: "", save_file: true)
      @site = site

    end
    def site=(t)
      @http = File.join(t, 'robots.txt')
    end

    # attr_reader :save_file

    def run
      save_txt_file = ''
      allow    = allow_robots
      disallow = disallow_robots
      if @save_file
        save_txt_file += "ALLOW:\n\n"
        unless allow.empty?
          allow.each do |list|
            save_txt_file += list
          end
        end
        save_txt_file += "DISALLOW:\n\n"
        unless disallow.empty?
          disallow.each do |list|
            save_txt_file += list
          end
        end
      else
        unless allow[1].empty?
          puts "ALLOW: "
          allow[1].each do |a|
            puts a
          end
        end
        unless disallow[1].empty?
          puts "Disallow: "
          disallow[1].each do |d|
            puts d
          end
        end
      end
    Snackhack2.file_save(@site, 'robots', save_txt_file) if @save_file
    end

    def allow_robots
      allow_dir = []
      http = Snackhack2.get(@http)
      if http.code == 200
        body = http.body.lines
        body.each do |l|
          allow_dir << l.split('Allow: ')[1] if l.match(/Allow:/)
        end
      else
        puts "[+] Not giving code 200.\n"
      end
      open_links = []
      allow_dir.each do |path|
        link = Snackhack2.get(@http)
        if link.code == 200
          valid_links = "#{@site}#{path}"
          open_links << valid_links
        end
      end
      [ open_links, allow_dir]
    end

    def disallow_robots
      http = Snackhack2.get(@http)
      disallow_dir = []
      if http.code == 200
        body = http.body.lines
        body.each do |l|
          if l.match(/Disallow:/)

            disallow_dir << l.split('Disallow: ')[1]
          end 
        end
      else
        puts "[+] Not giving code 200.\n"
      end
      open_links = []
      disallow_dir.each do |path|
        link = Snackhack2.get(File.join(@site, path.strip))
        if link.code == 200
          valid_links = "#{@site}#{path}"
          open_links << valid_links
        end
      rescue StandardError
      end
      [ open_links, disallow_dir]
    end
  end
end
