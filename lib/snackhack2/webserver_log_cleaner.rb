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
  class AuthLog
    attr_accessor :ip, :user
    def initialize(path: File.join("/var", "log", "auth.log.2"), user: "root")
      @ip = ip
      @user = user 
      @user_list = ["user", "admin", "nobody", "proxy", "test", "tom", "frank", "irc", "sshd", "mail"]
      @path = path
    end
    def remove_username
      out = ""
      File.readlines(@path).each do |user|
        new_user = user.match(/#{@user}/)
        if new_user.to_s.eql?(@user)
          out += user.gsub(new_user.to_s, @user_list.sample)
        else
          out += user
        end
      end
    File.delete(@path)
    File.open(@path, 'w+') { |file| file.write(out) }
    end
    def remove_ip
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
    def remove_all
      remove_ip
      remove_username
    end
  end
end
