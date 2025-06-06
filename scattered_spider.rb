require './lib/snackHack2'
require 'sqlite3'
require 'colorize'
# https://www.silentpush.com/blog/scattered-spider-2025/
=begin
tld = [
	".com",
	".co",
	".us",
	".net",
	".org",
	".help",
	""
]
=end
keywords = [
	"connect",
	"corp",
	"duo",
	"help",
	"he1p",
	"helpdesk",
	"helpnow",
	"info",
	"internal",
	"mfa",
	"my",
	"okta",
	"onelogin",
	"schedule",
	"service",
	"servicedesk",
	"servicenow",
	"rci",
	"rsa",
	"sso",
	"ssp",
	"support",
	"usa",
	"vpn",
	"work",
	"dev",
	"workspace",
	"it",
	"ops",
	"hr"
]
found_ips = []
not_found = []
db = SQLite3::Database.new 'test_db.db'
begin
 	db.execute('create table IF NOT EXISTS NotActive (id integer primary key autoincrement, domain text);')
 	db.execute('create table IF NOT EXISTS Active (id integer primary key autoincrement, domain text, IPs text);')
rescue StandardError => e
    puts "ERROR: #{e}".red
end
# top-10000-domains.txt
=begin
File.readlines("test.txt").each do |domain|
	keywords.each do |keywords|
		new_domain = "#{keywords}-#{domain}".strip
		ip = Snackhack2::Dns.new(new_domain).a
		if !ip.empty?
			found_ips << [[new_domain, ip]]
			puts "#{new_domain} #{ip}".green
			db.execute 'insert into Active values (?, ?, ?)', nil, new_domain, ip.join(" ")
		else
			if db.execute("select domain from NotActive where domain = '#{new_domain}';").empty?
				puts "NOT FOUND: #{new_domain}".red
				db.execute 'insert into NotActive values (?, ?)', nil, new_domain
			end
		end
	end
end
=end

db.execute("select * from Active;").each do |i|
	p i
end
