# frozen_string_literal: true

require 'httparty'
require 'spidr'
module Snackhack2
  class PhoneNumber
    attr_accessor :save_file

    def initialize(site, save_file: true)
      @site = site
      @save_file = save_file
    end

    attr_reader :save_file

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
      return if numbers.empty?
      return unless @save_file

      hostname = URI.parse(@site).host
      puts "[+] Saving to #{hostname}_phone_numbers.txt..."
      File.open("#{hostname}_phone_numbers.txt", 'w+') { |file| file.write(numbers.join("\n")) }
    end

    def spider
      phone_numbers = []
      Spidr.start_at(@site, max_depth: 2) do |agent|
        agent.every_page do |page|
          body = page.to_s
          if body.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)
            pn = body.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)
            phone_numbers << pn.compact unless phone_numbers.include?(pn.to_s)
          end
        end
      end
      return if phone_numbers.empty?
      return unless @save_file

      hostname = URI.parse(@site).host
      puts "[+] Saving to #{hostname}_phone_numbers.txt..."
      File.open("#{hostname}_phone_numbers.txt", 'w+') { |file| file.write(phone_numbers.join("\n")) }
    end
  end
end
