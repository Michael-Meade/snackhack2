# frozen_string_literal: true

# Process.spawn("ruby -run -ehttpd . -p8008")
# sleep 10
module Snackhack2
  class HostInjection
    attr_accessor :site, :host_ip, :old_host_ip

    def initialize
      @site = site
      p @site
      @host_ip = host_ip
      @old_host_ip = old_host_ip
    end
    def host_ip
      p @site
      response = HTTParty.get(@site, headers: { "Host" => @old_host_ip})
      puts response.body
    end
    def double_host_ip
      response = HTTParty.get(@site, headers: { "Host" => "#{@old_host_ip}", "Host" => "#{@host_ip}"})
      puts response.body
    end
  end
end




