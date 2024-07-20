require 'httparty'
require 'spidr'
module Snackhack2
  class PhoneNumber
    attr_accessor :save_file

    def initialize(site, save_file: true)
      @site = site
      @save_file = save_file
    end

    def save_file
      @save_file
    end

    def run
      numbers = []
      http = HTTParty.get(@site)
      if http.code == 200
        regex = http.body
        t = regex.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)
        out = t.map { |n| n[0] }.compact
        numbers << out
      else
        puts "[+] Status code: #{http.code}"
      end
      if !numbers.empty?
        if @save_file
          hostname = URI.parse(@site).host
          puts "[+] Saving to #{hostname}_phone_numbers.txt..."
          File.open("#{hostname}_phone_numbers.txt", 'w+') { |file| file.write(numbers.join("\n")) }
        end
      end
    end

    def spider
      phone_numbers = []
      Spidr.start_at(@site, max_depth: 4) do |agent|
        agent.every_page do |page|
          body = page.to_s
          if body.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)
            pn = body.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)[0]
            if !pn.nil?
              pn = pn.compact.select { |i| !i.to_s.nil? }.shift
              if !phone_numbers.include?(pn.to_s)
                phone_numbers << pn
              end
            end
          end
        end
      end
      if !phone_numbers.empty?
        Snackhack2::file_save(@site, "phonenumbers", phone_numbers.join("\n")) if @save_file
      end
    end
  end
end
