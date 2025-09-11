# frozen_string_literal: true

require 'net/ssh'
module Snackhack2
  class SSHForwardRemote
    attr_accessor :site, :user, :pass, :key, :lport, :lsite, :rport

    def initialize
      @site = site
      @user = user
      @pass = pass
      @key  = key
      @lport = lport
      @lsite = lsite
      @rport = rport
    end

    def run
      Net::SSH.start(@site, @user, password: @pass, keys: @key) do |ssh|
        ssh.forward.remote(@lport, @lsite, @rport)
        puts '[+] Starting SSH remote forward tunnel'
        ssh.loop { true }
      end
    end
  end
end
