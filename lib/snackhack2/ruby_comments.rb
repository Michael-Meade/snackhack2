module Snackhack2
	class RubyComments
		attr_accessor :file
		def initialize
			@file = file
		end
		def comments
			if File.exist?(@file)
				File.readlines(@file).each do |l|
					line = l.to_s
					if line.to_s.start_with?("#")
						puts l
					end
				end
			else 
				puts "#{@file} does not exist."
			end
		end
	end
end