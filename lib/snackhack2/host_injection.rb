# frozen_string_literal: true

# Process.spawn("ruby -run -ehttpd . -p8008")
# sleep 10
module Snackhack2
  class HostInjection
    attr_accessor :site, :new_host_ip, :old_host_ip
    # old_host_ip: the IP of the host (public IP) that its supposed to be
    # new_host_ip: the IP of the host to bypass access controls
    def initialize
      @site = site
    end
    def host_ip
       unless @old_host_ip.nil?
            response = HTTParty.get(@site, headers: { "Host" => @old_host_ip})
            puts response.body
      end
    end
    def double_host_ip
      unless @old_host_ip.nil?
            response = HTTParty.get(@site, headers: { "Host" => @old_host_ip, "Host" => @new_host_ip})
            puts response.body
      end
    end
    def x_forwarded
      unless @old_host_ip.nil?
            response = HTTParty.get(@site, headers: { "Host" => @old_host_ip, "X-Forwarded-Host" => @new_host_ip})
            puts response.body
      end
    end
  end
end




