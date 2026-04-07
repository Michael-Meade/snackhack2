require 'sqlite3'
db = SQLite3::Database.new 'local_scan.db'
db.execute "SELECT * FROM '192.168.0.162'" do |row|
  puts row
end

db.close