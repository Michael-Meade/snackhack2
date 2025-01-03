require 'httparty'
require 'spidr'
module Snackhack2
  class PhoneNumber
    attr_accessor :save_file, :site

    def initialize(save_file: true)
      @site = site
      @save_file = save_file
    end

    def save_file
      @save_file
    end

    def run
      numbers = []
      http = Snackhack2::get(@site)
      if http.code == 200
        regex = http.body
        phone = regex.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)
        out = phone.map { |n| n[0] }.compact
        numbers << out
      else
        puts "\n\n[+] Status code: #{http.code}"
      end
      if !numbers.empty?
        if @save_file
          hostname = URI.parse(@site).host
          Snackhack2::file_save(@site, "phone_numbers", numbers.join("\n"))
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
