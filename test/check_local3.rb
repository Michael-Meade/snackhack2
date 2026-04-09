require_relative '../lib/snackHack2'
require 'sqlite3'
require 'time'
require 'colorize'
# create database
@db = SQLite3::Database.new 'local_scan.db'
def add_scan
	sl = Snackhack2::ScanLocal.new
	found_ips = sl.get_ips_hash("192.168.0.1/24")
	found_ips.each do |ip, host|
		#unix time stamp
		time = Time.now.to_i
		  
		# Makes IP able to be inserted into db
		ip = "'#{ip}'"

		puts "\n\n\n"
		# changes '.' to '_'
		host = host.gsub(".", "_")
		puts "Ip:\s#{ip}\nHost:\s#{host}"
		puts "\n\n\n"

		# Creates the table if does not exist. 
		@db.execute("CREATE TABLE IF NOT EXISTS #{ip} (id integer primary key, ip integer, date TEXT, host TEXT);")
		# inserts it into the table... by IP. 
		@db.execute "insert into #{ip} values ( ?, ?, ?, ?)", nil, ip, time, host
	end
end



add_scan
time_now = Time.now.strftime("%d/%m/%Y %H:%M")
File.open('output.txt', 'a') { |f| f.write("#{time_now}\n") } 
