require 'typhoeus'
require 'uri'
require 'optparse'
require 'colorize'
#require_relative 'reports'
options = {}
OptionParser.new do |o|
  o.banner = "Usage example: test.rb --url http://localhost:4567/?url=SSRF.\n You need to put SSRF."
  options[:banner] = o.banner

  o.on("--url URL") do |d|
    options[:url] = d
  end


  # sets the uo as options[:ps]
  # need to give the program the IP
  o.on("--ps ip", "Port scan") do |dd|
    options[:ps] = dd
  end
end.parse!

def requests(url, url2)
  hydra = Typhoeus::Hydra.hydra
  r = Typhoeus::Request.new(url)
  hydra.queue(r)
  r.on_complete do |response|
    puts response.headers
    # get the response code
    code = response.code.to_i
    r = Typhoeus::Request.new(url)
    # if the response code has the 
    # the status of 200
    if code.to_i  == 200
        uri = URI(url).host
	      puts uri
        # Reports.new(uri, url).save_site
    end
  end
  
  second_r = Typhoeus::Request.new(url2)
  hydra.queue second_r
  hydra.run
end


if options[:ps]
    # all the possible ports
    max_port = 65535
    # combine the URL and the IP for the port
    url      = options[:url].gsub("SSRF", options[:ps] + ":")
    for i in 0..max_port.to_i
      ii = i+=1
      requests(url + i.to_s, url + ii.to_s)
      i+=2
    end
end

