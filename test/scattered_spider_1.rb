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
# get all the possible scripts in an array
sites = File.readlines("scattered_spider_posible_targets.txt")

# stores the generated sites
new_sites = []
sites.each do |s|
	keywords.each do |k|
		domains.each do |d|
			# keyword-site-domain
			site = "#{k}-#{s}#{d}"
			puts site
			# adds the new site to the array
			new_sites << site
		end
	end
end