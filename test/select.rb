require 'sqlite3'

@db = SQLite3::Database.new 'local_scan.db'

tables = @db.execute("SELECT name FROM sqlite_master WHERE type='table';").flatten
t = []
tables.each do |table|
	t << table
end
t.each do |tt|
	@db.execute("select * from '#{tt}' ").each do |id, ip, date, hostname|
		puts "ID:\s#{id}"
		puts "IP:\s#{ip}"
		puts "Date:\s#{date}"
		puts "Host:\s#{hostname}"
		print("\n\n\n\n")
	end
end