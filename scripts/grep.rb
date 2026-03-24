# purpose of this script is to take the GA from the top
# million sites and save them in a file named `top_gas4.txt`
# it is saved in this foramt GA Code:website. 

# This script will get the top 10 most common ones found in the 
# file and display it.

data = {}


File.open("top_gas4.txt").each do |line|
	ga, site  = line.chomp.split(":")
	unless data.has_key?(ga)
		data[ga] = 1
	else
		data[ga] += 1
	end	
end
data.sort_by { |k, v| -v }.first(10).to_h.each do |ga, count|
	puts "GA: #{ga}"
	puts "Count: #{count}\n\n"
end