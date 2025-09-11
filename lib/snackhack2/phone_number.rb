# frozen_string_literal: true

require 'httparty'
require 'spidr'
module Snackhack2
  class PhoneNumber
    attr_accessor :save_file, :site

    def initialize(save_file: true)
      @site = site
      @save_file = save_file
    end

    attr_reader :save_file

    def run
      numbers = []
      http = Snackhack2.get(@site)
      if http.code == 200
        regex = http.body
        phone = regex.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)
        out = phone.map { |n| n[0] }.compact
        numbers << out
      else
        puts "\n\n[+] Status code: #{http.code}"
      end
      return if numbers.empty?
      return unless @save_file

      URI.parse(@site).host
      Snackhack2.file_save(@site, 'phone_numbers', numbers.join("\n"))
    end

    def spider
      phone_numbers = []
      Spidr.start_at(@site, max_depth: 4) do |agent|
        agent.every_page do |page|
          body = page.to_s
          if body.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)
            pn = body.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)[0]
            unless pn.nil?
              pn = pn.compact.reject { |i| i.to_s.nil? }.shift
              phone_numbers << pn unless phone_numbers.include?(pn.to_s)
            end
          end
        end
      end
      return if phone_numbers.empty?

      Snackhack2.file_save(@site, 'phonenumbers', phone_numbers.join("\n")) if @save_file
    end
  end
end
