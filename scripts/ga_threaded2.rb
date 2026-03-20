require 'parallel'
require_relative '../lib/snackHack2'
# Input and Output files
input_file = "top-1000000-domains.txt"
output_file = "top_gas3.txt"


thread_count = 150
count = 0

Parallel.each(File.foreach(input_file), in_threads: thread_count) do |line|
  site = line.strip
  next if site.empty?

  begin
    ga = Snackhack2::GoogleAnalytics.new
    ga.site = "https://#{site}"
    
    results = ga.run
    puts "count: #{count}"
    g = results.is_a?(Array) ? results.shift : nil

    if g && !g.include?("[+] No Google Analytics found")
      result_string = "#{g.strip}:#{site}"
      puts "[FOUND] #{result_string}"
      
      File.open(output_file, 'a') { |file| file.puts(result_string) }
    end
    count += 1
  rescue
    next
  end
end
