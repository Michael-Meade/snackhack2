require 'thread'
require_relative '../lib/snackHack2'

THREAD_COUNT = 20

queue = Queue.new
mutex = Mutex.new


File.foreach("top-1000000-domains.txt") do |site|
  queue << site.strip
end

count = 0

workers = THREAD_COUNT.times.map do
  Thread.new do
    ssl = Snackhack2::SSLCert.new

    while true
      site = nil

      begin
        site = queue.pop(true) 
      rescue ThreadError
        break 
      end

      begin
        ssl.site = "https://#{site}"

        mutex.synchronize do
          count += 1
          puts "count: #{count}"
        end

        s = ssl.get_cert(print_status: false)
        puts "#{s}:#{site}"

        unless s.nil?
          mutex.synchronize do
            File.open("top_ssl.txt", 'a') do |file|
              file.write("#{s}:#{site}\n")
            end
          end
        end

      rescue => e
        puts "Error with #{site}: #{e}"
      end
    end
  end
end


workers.each(&:join)