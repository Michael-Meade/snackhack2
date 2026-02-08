require './lib/snackHack2'
require 'sqlite3'
require 'colorize'
require 'kmeans-clusterer'
# https://www.silentpush.com/blog/scattered-spider-2025/
tld = [
   ".com",
   ".co",
   ".us",
   ".net",
   ".org",
   ".help",
 ]
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
sites = [
	"boeing.com",
	"collinsaerospace.com",
	"lockheedmartin.com",
	"geaerospace.com",
	"altonaviation.com",
	"wheelsup.com",
	"hondajet.com",
	"cirrusaircraft.com",
	"atlanticaviation.com",
	"jetaviation.com",
	"solairus.aero",
	"airbus.com",
	"menziesaviation.com",
	"rtx.com",
	"safran-group.com",
	"leonardo.com",
	"aercap.com",
	"claylacy.com",
	"aarcorp.com",
	"diehl.com",
	"standardaero.com",
	"flyxo.com",
	"dynamicaviation.com",
	"muncieaviation.com",
	"wingaviation.com",
	"duncanaviation.aero",
	"modern-aviation.com",
	"cscos.com",
	"suncountry.com",
	"mccarthy.com"
]
found = []
require 'net/http'
require 'openssl'
sites.each do |domain|
	keywords.each do |keywords|
	    new_domain = "#{keywords}.#{domain}".strip
	    ip = Snackhack2::Dns.new
	    ip.site = new_domain
	    ip = ip.a
	     unless ip.empty?
	     	#puts "#{new_domain} #{ip}".green
	     	begin
	     		puts "#{new_domain}"
				uri = URI::HTTPS.build(host: new_domain)
				response = Net::HTTP.start(uri.host, uri.port, :use_ssl => true)
				cert = response.peer_cert
				puts cert.serial
			rescue OpenSSL::SSL::SSLError,Net::OpenTimeout, Errno::EHOSTUNREACH
			end
	     	found << [new_domain, ip]
	     end
	end
end
=begin
new_found = {}
found = [["support.boeing.com", ["34.226.36.52", "34.226.36.53", "34.226.36.51"]], ["it.lockheedmartin.com", ["199.60.103.2", "199.60.103.254"]], ["my.geaerospace.com", ["104.18.42.182", "172.64.145.74"]], ["corp.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["duo.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["help.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["he1p.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["helpdesk.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["helpnow.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["info.wheelsup.com", ["104.17.70.206", "104.17.73.206", "104.17.71.206", "104.17.72.206", "104.17.74.206"]], ["internal.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["mfa.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["my.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["okta.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["onelogin.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["schedule.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["service.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["servicedesk.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["servicenow.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["rci.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["rsa.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["sso.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["ssp.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["support.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["usa.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["vpn.wheelsup.com", ["100.12.16.43"]], ["work.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["dev.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["workspace.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["it.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["ops.wheelsup.com", ["172.64.149.244", "104.18.38.12"]], ["hr.wheelsup.com", ["104.18.38.12", "172.64.149.244"]], ["dev.hondajet.com", ["3.214.246.128"]], ["connect.cirrusaircraft.com", ["198.62.161.239"]], ["internal.cirrusaircraft.com", ["13.111.18.27"]], ["service.cirrusaircraft.com", ["198.62.161.10"]], ["sso.cirrusaircraft.com", ["198.62.161.24"]], ["vpn.cirrusaircraft.com", ["198.62.161.254"]], ["it.cirrusaircraft.com", ["198.62.161.22"]], ["mfa.jetaviation.com", ["199.19.209.163"]], ["my.jetaviation.com", ["199.19.209.181"]], ["sso.jetaviation.com", ["199.19.209.211"]], ["info.solairus.aero", ["199.60.103.254", "199.60.103.2"]], ["okta.solairus.aero", ["3.33.145.223", "15.197.134.95"]], ["support.solairus.aero", ["216.198.53.6", "216.198.54.6"]], ["vpn.solairus.aero", ["50.232.19.142"]], ["info.airbus.com", ["45.223.136.5"]], ["sso.rtx.com", ["52.245.211.48"]], ["connect.leonardo.com", ["185.51.13.216"]], ["corp.leonardo.com", ["185.51.13.216"]], ["duo.leonardo.com", ["185.51.13.216"]], ["help.leonardo.com", ["185.51.13.216"]], ["he1p.leonardo.com", ["185.51.13.216"]], ["helpdesk.leonardo.com", ["185.51.13.216"]], ["helpnow.leonardo.com", ["185.51.13.216"]], ["info.leonardo.com", ["185.51.13.216"]], ["internal.leonardo.com", ["185.51.13.216"]], ["mfa.leonardo.com", ["185.51.13.216"]], ["my.leonardo.com", ["185.51.13.216"]], ["okta.leonardo.com", ["185.51.13.216"]], ["onelogin.leonardo.com", ["185.51.13.216"]], ["schedule.leonardo.com", ["185.51.13.216"]], ["service.leonardo.com", ["185.51.13.216"]], ["servicedesk.leonardo.com", ["185.51.13.216"]], ["servicenow.leonardo.com", ["185.51.13.216"]], ["rci.leonardo.com", ["185.51.13.216"]], ["rsa.leonardo.com", ["185.51.13.216"]], ["sso.leonardo.com", ["185.51.13.216"]], ["ssp.leonardo.com", ["185.51.13.216"]], ["support.leonardo.com", ["185.51.13.212"]], ["usa.leonardo.com", ["185.51.13.216"]], ["vpn.leonardo.com", ["185.51.13.216"]], ["work.leonardo.com", ["185.51.13.216"]], ["dev.leonardo.com", ["185.51.13.216"]], ["workspace.leonardo.com", ["185.51.13.216"]], ["it.leonardo.com", ["185.51.13.216"]], ["ops.leonardo.com", ["185.51.13.216"]], ["hr.leonardo.com", ["185.51.13.216"]], ["connect.aercap.com", ["195.109.107.76"]], ["connect.claylacy.com", ["12.68.21.82"]], ["helpdesk.claylacy.com", ["15.197.225.128", "3.33.251.168"]], ["info.claylacy.com", ["199.60.103.254", "199.60.103.2"]], ["my.claylacy.com", ["158.101.39.224"]], ["mfa.aarcorp.com", ["23.196.3.190", "23.196.3.199"]], ["servicenow.aarcorp.com", ["149.96.18.227"]], ["sso.aarcorp.com", ["23.64.112.17", "23.64.112.6"]], ["info.standardaero.com", ["199.15.213.2"]], ["vpn.standardaero.com", ["205.200.103.8"]], ["connect.flyxo.com", ["54.76.170.188", "52.18.166.179", "34.242.135.116"]], ["corp.flyxo.com", ["54.76.170.188", "52.18.166.179", "34.242.135.116"]], ["duo.flyxo.com", ["54.76.170.188", "34.242.135.116", "52.18.166.179"]], ["help.flyxo.com", ["34.242.135.116", "54.76.170.188", "52.18.166.179"]], ["he1p.flyxo.com", ["34.242.135.116", "54.76.170.188", "52.18.166.179"]], ["helpdesk.flyxo.com", ["34.242.135.116", "54.76.170.188", "52.18.166.179"]], ["helpnow.flyxo.com", ["52.18.166.179", "54.76.170.188", "34.242.135.116"]], ["info.flyxo.com", ["52.18.166.179", "54.76.170.188", "34.242.135.116"]], ["internal.flyxo.com", ["54.76.170.188", "34.242.135.116", "52.18.166.179"]], ["mfa.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["my.flyxo.com", ["54.211.167.132", "3.209.6.227"]], ["okta.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["onelogin.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["schedule.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["service.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["servicedesk.flyxo.com", ["52.18.166.179", "54.76.170.188", "34.242.135.116"]], ["servicenow.flyxo.com", ["34.242.135.116", "54.76.170.188", "52.18.166.179"]], ["rci.flyxo.com", ["54.76.170.188", "52.18.166.179", "34.242.135.116"]], ["rsa.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["sso.flyxo.com", ["54.76.170.188", "34.242.135.116", "52.18.166.179"]], ["ssp.flyxo.com", ["54.76.170.188", "34.242.135.116", "52.18.166.179"]], ["support.flyxo.com", ["108.139.29.23", "108.139.29.55", "108.139.29.84", "108.139.29.107"]], ["usa.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["vpn.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["work.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["dev.flyxo.com", ["52.18.166.179", "34.242.135.116", "54.76.170.188"]], ["workspace.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["it.flyxo.com", ["52.18.166.179", "54.76.170.188", "34.242.135.116"]], ["ops.flyxo.com", ["34.242.135.116", "52.18.166.179", "54.76.170.188"]], ["hr.flyxo.com", ["34.242.135.116", "54.76.170.188", "52.18.166.179"]], ["ops.dynamicaviation.com", ["20.140.186.105"]], ["internal.wingaviation.com", ["98.129.229.48"]], ["vpn.wingaviation.com", ["104.63.138.161"]], ["dev.modern-aviation.com", ["199.250.200.28"]], ["helpdesk.cscos.com", ["216.198.53.6", "216.198.54.6"]], ["vpn.cscos.com", ["208.49.41.200"]], ["connect.suncountry.com", ["45.60.170.55"]], ["corp.suncountry.com", ["45.60.170.55"]], ["duo.suncountry.com", ["45.60.170.55"]], ["help.suncountry.com", ["45.60.170.55"]], ["he1p.suncountry.com", ["45.60.170.55"]], ["helpdesk.suncountry.com", ["45.60.170.55"]], ["helpnow.suncountry.com", ["45.60.170.55"]], ["internal.suncountry.com", ["45.60.170.55"]], ["mfa.suncountry.com", ["45.60.170.55"]], ["my.suncountry.com", ["45.60.170.55"]], ["okta.suncountry.com", ["45.60.170.55"]], ["onelogin.suncountry.com", ["45.60.170.55"]], ["schedule.suncountry.com", ["45.60.170.55"]], ["service.suncountry.com", ["45.60.170.55"]], ["servicedesk.suncountry.com", ["45.60.170.55"]], ["servicenow.suncountry.com", ["45.60.170.55"]], ["rci.suncountry.com", ["45.60.170.55"]], ["rsa.suncountry.com", ["45.60.170.55"]], ["sso.suncountry.com", ["45.60.170.55"]], ["ssp.suncountry.com", ["45.60.170.55"]], ["support.suncountry.com", ["45.60.170.55"]], ["usa.suncountry.com", ["45.60.170.55"]], ["vpn.suncountry.com", ["45.60.170.55"]], ["work.suncountry.com", ["45.60.170.55"]], ["dev.suncountry.com", ["45.60.170.55"]], ["workspace.suncountry.com", ["45.60.170.55"]], ["it.suncountry.com", ["45.60.170.55"]], ["ops.suncountry.com", ["45.60.170.55"]], ["hr.suncountry.com", ["45.60.170.55"]], ["help.mccarthy.com", ["52.173.188.156"]], ["info.mccarthy.com", ["72.167.251.179"]], ["support.mccarthy.com", ["108.138.106.49", "108.138.106.28", "108.138.106.16", "108.138.106.30"]]]
found.each do |site, ips|
	ips.each do |ip|
		if !new_found.has_key?(ip)

			new_found[ip] = 1
		else
			new_found[ip] += 1
		end
	end
end
sorted_new_found = new_found.sort_by{|k,v| -v}


sorted_new_found.each do |ip, count|
	puts "#{ip} -> #{count}"
end
=end
