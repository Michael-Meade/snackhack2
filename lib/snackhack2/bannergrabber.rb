 # frozen_string_literal: true
require 'socket'
module Snackhack2
  class BannerGrabber
    attr_accessor :port, :site, :save_file

    def initialize(port: 443, save_file: true)
      @site    = site
      @port    = port
      @save_file = save_file
    end

    def run
      nginx
      apache2
      wordpress
      get_ssh_info
    end
    def headers
      @headers = Snackhack2.get(@site).headers
    end
    def nginx
      if headers['server'].include?("nginx")
        puts "[+] Server is running NGINX... Now checking if #{File.join(@site, 'nginx_status')} is valid..."
        nginx = Snackhack2.get(File.join(@site, 'nginx_status'))
        if nginx.code == 200
          puts "Check #{@site}/nginx_status"
        else
          puts "Response code: #{nginx.code}... nginx_status not giving 200"
        end
      else 
        puts "[+] No nginx detected..."
      end
    end

    def curl
      # uses cURL to head a website header
      servers = ''
      # rus the curl command to get the headers of the given site. 
      cmd = `curl -s -I #{@site.gsub('https://', '')}`
      # extracts the server header from the curl results
      version = cmd.split('Server: ')[1].split("\n")[0].strip
      if @save_file
        servers += version.to_s
      else
        puts "Banner: #{cmd.split('Server: ')[1].split("\n")[0]}"
      end

      # saves the results if '@save_file' is set to true.
      Snackhack2.file_save(@site, 'serverversion', servers) if @save_file
    end

    def apache2
      if headers['server'].match(/Apache/)
        puts "[+] Server is running Apache2... Now checking #{File.join(@site, 'server-status')}..."
        apache = Snackhack2.get(File.join(@site, 'server-status'))
        # status code 200 means the request was successful.
        if apache.code == 200
          puts "Check #{@site}/server-status"
        else
          puts "[+] Response Code: #{apache.code}...\n\n"
        end
      else
        puts "Apache2 is not found...\n\n"
      end
    end

    def wordpress
      wp = Snackhack2.get(@site).body
      # return unless wp.match(/wp-content/)

      puts "[+] Wordpress '/wp-content' found [+]\n\n\n" if wp.match(/wp-content/)

      
    end
    def types
      {
        "cloudflare": [ "cf-cache-status", "cf-ray", "cloudflare"],
        "aws CloudFront": [ "X-Amz-Cf-Pop", "X-Amz-Cf-Id", "CloudFront", "x-amz-cf-pop", "x-amz-cf-id", "cloudfront.net"] 
      }
    end
    def find_headers
      # make a request to the site and grab the headers. 
      Snackhack2.get(@site).headers
    end

    def get_tcp_info(ports: "")
      ports = 22 if ports.empty?
      begin
        TCPSocket.new(@site, ports).recv(1024)
      rescue => e
        puts "ERROR OCCURRED"
      end
    end
    def cloudflare(print_status: true)
      # the purpose of this method is to 
      # check to see if a site has 
      # cloudflare in the headers

      cf_status = false
      cf_count  = 0

      # access the 'types' hash to get the cloudflare strings. 
      cf = types[:"cloudflare"]

      # make a single get request to the site defined at '@site'
      find_headers.each do |k,v|
        # if the key is in the array cf
        if cf.include?(k)
          cf_status = true
          cf_count += 1
        end
      end
      if print_status
        # cf_status[0] : the status if cloudflare was found
        # cf_count[1]  : the number of found elements in the 'cloudflare' hash. 
        return [cf_status, cf_count]
      else
        if cf_status
          puts "Cloudflare was found. The count is: #{cf_count}"
        else
          puts "Cloudflare was NOT found. The count is #{cf_count}"
        end
      end
    end
    def cloudfront(print_status: false)
      # the purpose of this method is to 
      # check to see if a site has 
      # cloudflare in the headers

      cf_status = false
      cf_count  = 0

      # access the 'types' hash to get the cloudflare strings. 
      cf = types[:"aws CloudFront"]

      # make a single get request to the site defined at '@site'
      find_headers.each do |k,v|
        # if the key is in the array cf
        if cf.include?(k)
          cf_status = true
          cf_count += 1
        end
      end
      unless print_status
        # cf_status[0] : the status if cloudfront was found
        # cf_count[1]  : the number of found elements in the 'cloudfront' hash. 
        return [cf_status, cf_count]
      else
        if cf_status
          puts "Cloudfront was found. The count is: #{cf_count}"
        else
          puts "Cloudfront was NOT found. The count is #{cf_count}"
        end
      end
    end
    def detect_header(return_status: true)
      # stores the data found in 
      # the headers.
      data = {}
      # loops through the hash stored in the 'types' method.
      # the t_k is the KEY of the hash
      # the t_v is the VALUE of the hash.
      types.each do |t_k, t_v|
        # make a single get request to the site 
        # to get the headers.
        find_headers.each do |fh_k, fh_v|
          # Get the keys from the 'types' method
          # which is basicly a hash
          type_key = t_k
          # uses the key of the 'types' hash 
          # to see if includes the string found in 'fh_k'
          if types[type_key].include?(fh_k)
            if data.has_key?(type_key)
              data[type_key] <<  fh_k
            else
              data[type_key] = [fh_k]
            end
          end
        end
      end
      if return_status
        return data
      else
        data.each do |k,v|
          puts "K:#{k}"
          puts "V: #{v}"
        end
      end
    end
    def server
      @headers['server']
    end

    attr_reader :site
    private :find_headers
  end  
end
# to do: instead of doing mutiple methods for each type of
# header make one method that is dynamic...
# and can do different ones