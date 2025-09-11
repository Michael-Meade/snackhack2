require './lib/snackHack2'
require 'sqlite3'
insurance = [ "unitedhealthgroup.com",
	"berkshirehathaway.com",
	"aetna.com",
	"thecignagroup.com",
	"elevancehealth.com",
	"centene.com",
	"humana.com",
	"EVERETTCASH.COM",
	"1STATLANTICSURETY.COM",
	"4everlife.com",
	"21ST.COM",
	"FARMERS.COM",
	"wtwco.com",
	"360ins.com",
	"bcbsnm.com",
	"harfordmutual.com",
	"ACENTRALINSURANCE.COM",
	"aaalife.com",
	"absolutetotalcare.com",
	"academicgroup.com",
	"ACCELINS.COM",
	"CHUBB.COM",
	"acstarins.com",
	"AIE-NY.COM",
	"BERKLEYLUXURYGROUP.COM",
	"DELTADENTALMO.COM",
	"advocus.com",
	"AMERICAN-EQUITY.COM",
	"AIG.COM",
	"HANOVER.COM",
	"fnf.com",
	"MYALLSAVERS.COM",
	"GOLDENRULE.COM",
	"ENCOVA.COM",
	"fami.com",
	"AWAC.COM",
	"ALLSTATE.COM",
	"alohacare.org",
	"amspecialty.com",
	"KEMPER.COM",
	"greatamericaninsurancegroup.com",
	"americannational.com",
	"americanins.com",
	"avmed.org",
	"alkemeins.com",
	"inszoneinsurance.com",
	"oakbridgeinsurance.com",
	"king-insurance.com",
	"crestins.com",
	"hotchkissinsurance.com",
	"brightlinedealeradvisors.com",
	"thecasongroup.com",
	"ehdinsurance.com",
	"geico.com",
	"progressive.com",
	"travelers.com",
	"central-insurance.com",
	"thehartford.com",
	"esurance.com",
	"secura.net",
	"grangeinsurance.com",
	"cinfin.com",
	"fbitn.com",
	"afba.com"
]
keywords = [ "connect",
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
	"ops"

]

domains = [
	".com",
	 ".co",
	 ".us",
	 ".net",
	 ".org",
	 ".help"
]


@db = SQLite3::Database.new 'spider.db'
begin
  @db.execute('create table IF NOT EXISTS NotActive (id integer primary key autoincrement, domain text);')
  @db.execute('create table IF NOT EXISTS Active (id integer primary key autoincrement, domain text, IPs text);')
rescue StandardError => e
  puts "ERROR: {e}".red
end

insurance.each do |d|
	keywords.each do |key|
	    site =  d.split(".")[0]
	    domains.each do |i|
	    	new_site = "#{key}.#{site}#{i}"
	    	ip = Snackhack2::Dns.new(new_site).a
     		if !ip.empty?
     			puts "#{new_site}\n#{ip}"
     			if @db.execute("select domain from Active where domain = '#{new_site}';").empty?
     				puts "#{new_site} not found in Active Table..."
     			  puts "#{new_site}\n\n\n"
     			  @db.execute 'insert into Active values (?, ?, ?)', nil, new_site, ip.join(" ")
     			end
     		else
     			@db.execute 'insert into NotActive values (?, ?)', nil, new_site
     		end
	   end
	end
end

=begin
@db.execute('select * from Active;').each do |i|
  	puts "#{i[0]} | #{i[1]} | #{i[2].strip.split(" ")}"
end
=end
