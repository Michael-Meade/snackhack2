require 'sqlite3'
require 'date'
require 'colorize'
db = SQLite3::Database.new 'local_scan.db'
tables = db.execute("SELECT name FROM sqlite_master WHERE type='table';").flatten

tables.each do |ip|
	current_time = Time.new
	get_last  = db.execute "SELECT * FROM '#{ip}'"
	id,ip,date,host      = get_last.last
	readable_time = Time.at(date.to_i).strftime("%Y-%m-%d %H:%M:%S")
	#p date.today
	time_since = Time.now.to_i - date.to_i
	puts "TIME:\s #{Time.at(current_time).strftime("%Y-%m-%d %H:%M:%S")}".red
	if  time_since.to_i <= 86400
		puts "TIME:\s#{Time.now.to_i}"
		puts "ID:\s#{id}"
		puts "UNIX:\s#{date}"
		puts "IP:\s#{ip}"
		puts "DATE:\s#{readable_time}"
		puts "HOST:\s#{host}\n\n\n"
	end
end
db.close

