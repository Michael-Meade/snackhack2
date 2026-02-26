module Snackhack2
	class RubyComments
		attr_accessor :file
		def initialize
			@file = file
		end
		def comment_block
			if File.exist?(@file)
			  comments = []
			  in_comment_block = false
			  File.readlines(@file).each do |file|
			    file.each_line do |line|
			      if line.strip.eql? '=begin'
			        in_comment_block = true
			        next
			      elsif line.strip.eql? '=end'
			        in_comment_block = false
			        next
			      end

			      if in_comment_block
			        comments << line
			      end
			    end
			  end
			  comments.each do |c|
			  	puts c
			  end
			else
				puts "#{@file} does not exist."
			end
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