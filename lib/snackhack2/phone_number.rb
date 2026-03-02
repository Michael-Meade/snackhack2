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
      found_numbers = []
      unless @site.include?("https://")
        @site = "https://#{@site}"
      else
        @site = site
      end
      http = Snackhack2.get(@site).body
      case http
      when (/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)
        ph_1 = http.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/).flatten
        found_numbers <<  ph_1 
      when /^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/
        ph_2 = http.scan(/^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/).flatten
        found_numbers << ph_2 
      when (/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/)
        ph_3 = http.scan(/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/).flatten
        found_numbers << ph_3 
      when (/^\+((?:9[679]|8[035789]|6[789]|5[90]|42|3[578]|2[1-689])|9[0-58]|8[1246]|6[0-6]|5[1-8]|4[013-9]|3[0-469]|2[70]|7|1)(?:\W*\d){0,13}\d$/).flatten
        ph_4 = http.scan((/^\+((?:9[679]|8[035789]|6[789]|5[90]|42|3[578]|2[1-689])|9[0-58]|8[1246]|6[0-6]|5[1-8]|4[013-9]|3[0-469]|2[70]|7|1)(?:\W*\d){0,13}\d$/))
        found_numbers << ph_4 
      when (/^(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/)
        ph_5 = http.scan(/^(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/)
        found_numbers << ph_5
      when (/^\+?[1-9][0-9]{7,14}$/)
        ph_6 = http.scan(/^\+?[1-9][0-9]{7,14}$/)
        found_numbers << ph_6
      when (/^\+?\d{1,4}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$/)
        ph_7 = http.scan(/^\+?\d{1,4}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$/)
        found_numbers << ph_7
      end
      numbers = found_numbers.flatten.compact
      if @save_file
        Snackhack2.file_save(@site, 'phone_numbers', numbers.join("\n"))
      else
        return numbers
      end 
    end
    def spider
      found_numbers = []
      Spidr.start_at(@site, max_depth: 4) do |agent|
        agent.every_page do |page|
          body = page.to_s
          # regex to extract phone numbers
          case body
          when (/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/)
            ph_1 = http.scan(/((\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4})/).flatten
            found_numbers <<  ph_1 
          when /^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/
            ph_2 = http.scan(/^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/).flatten
            found_numbers << ph_2 
          when (/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/)
            ph_3 = http.scan(/^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/).flatten
            found_numbers << ph_3 
          when (/^\+((?:9[679]|8[035789]|6[789]|5[90]|42|3[578]|2[1-689])|9[0-58]|8[1246]|6[0-6]|5[1-8]|4[013-9]|3[0-469]|2[70]|7|1)(?:\W*\d){0,13}\d$/).flatten
            ph_4 = http.scan((/^\+((?:9[679]|8[035789]|6[789]|5[90]|42|3[578]|2[1-689])|9[0-58]|8[1246]|6[0-6]|5[1-8]|4[013-9]|3[0-469]|2[70]|7|1)(?:\W*\d){0,13}\d$/))
            found_numbers << ph_4 
          when (/^(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/)
            ph_5 = http.scan(/^(\+0?1\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$/)
            found_numbers << ph_5
          when (/^\+?[1-9][0-9]{7,14}$/)
            ph_6 = http.scan(/^\+?[1-9][0-9]{7,14}$/)
            found_numbers << ph_6
          when (/^\+?\d{1,4}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$/)
            ph_7 = http.scan(/^\+?\d{1,4}?[-.\s]?\(?\d{1,3}?\)?[-.\s]?\d{1,4}[-.\s]?\d{1,4}[-.\s]?\d{1,9}$/)
            found_numbers << ph_7
          end
        end
      end
      unless phone_numbers.empty?
        if @save_file
          Snackhack2.file_save(@site, 'phonenumbers', phone_numbers.join("\n"))
        else
          return phone_numbers
        end
      end
    end
  end
end
