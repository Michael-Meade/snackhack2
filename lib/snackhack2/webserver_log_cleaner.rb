# frozen_string_literal: true

module Snackhack2
  class WebServerCleaner
    attr_accessor :ip
    def initialize(path: File.join('/var/log', 'access.log'))
      @ip   = ip
      @path = path
    end

    def run
      out = ''
      # generate random IP
      new_ip = Array.new(4) { rand(256) }.join('.')
      File.readlines(@path).each do |line|
        old_ip = line.match(/((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/)
        out += if old_ip.to_s == @ip
                 line.gsub(old_ip.to_s, new_ip)
               else
                 line
               end
      end
      File.delete(@path)
      File.open(@path, 'w+') { |file| file.write(out) }
    end
  end
end
