# frozen_string_literal: true

module Snackhack2
  class Comments
    attr_accessor :site

    def initialize
      @site = site
    end

    def run
      c = Snackhack2.get(@site)

      if c.code == 200
        body = c.body.split("\n")
        body.each_with_index do |l, i|
          line = l.strip
          if line.start_with?('<!--')
            puts body[i].next
          elsif line.include?('<!')
            puts body[i].next
          end
        end
      else
        puts "Status Code: #{c.code}\n"
      end
    end
  end
end
