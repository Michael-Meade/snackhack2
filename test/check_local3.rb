require_relative '../lib/snackHack2'
require 'sqlite3'
require 'time'
require 'colorize'
# create database
@db = SQLite3::Database.new 'local_scan.db'
def add_scan
	ips = []
	sl = Snackhack2::ScanLocal.new
	found_ips = sl.get_ips_hash("192.168.0.1/24")
	found_ips.each do |ip, host|
		table = @db.execute("SELECT name FROM sqlite_master WHERE type='table';").flatten
		if table.include?(ip)
			puts "New IP found: #{ip}".red
		end
		time = Time.now.strftime("%m/%d/%Y %H:%M")
		ips << ip
		ip = "'#{ip}'"

		puts "\n\n\n"
		host = host.gsub(".", "_")
		puts "Ip:\s#{ip}\nHost:\s#{host}"
		puts "\n\n\n"

		# Creates the table if does not exist. 
		@db.execute("CREATE TABLE IF NOT EXISTS #{ip} (id integer primary key, ip integer, date TEXT, host TEXT);")
		# inserts it into the table... by IP. 
		@db.execute "insert into #{ip} values ( ?, ?, ?, ?)", nil, ip, time, host
		#@db.execute("select * from #{ip}")
	end
end



add_scan
