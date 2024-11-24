

#Process.spawn("ruby -run -ehttpd . -p8008")
#sleep 10
module Snackhack2
  class SSRF
    attr_accessor :site
    def initialize
      @site = site
    end
    def ssrf
      url = @site.gsub("SSRF", "http://google.com")
      ht = HTTParty.get(url)
      if ht.body.include?("Search the world's information, including webpages, images, videos and more. Google has many special features to help you find exactly what you're looking for.")
        puts "Boom Shaka. It's vulnerable to SSRF..."
      end
    
    end
  end
end