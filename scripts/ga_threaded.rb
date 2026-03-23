require 'parallel'
require 'date'
require_relative '../lib/snackHack2'
# Input and Output files
input_file = "top-1000000-domains.txt"
output_file = "top_gas5.txt"


thread_count = 50
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
  rescue => e
    
    d = DateTime.now
    time = d.strftime("%d/%m/%Y %H:%M")
    File.open("ga_logs.txt", 'a') { |file| file.write("#{time} - #{e}\n") }
    next
  end
end