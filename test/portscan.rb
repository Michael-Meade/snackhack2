# frozen_string_literal: true

require_relative '../lib/snackHack2'
tcp = Snackhack2::PortScan.new
# generate `100` randomly generated IPS

# tcp.count = 100
# Perform a mass scan on the IPs generated
# tcp.mass_scan

# read all the files created by the scan 
# looking for any IPs that have port `443`.
tcp.ports_extractor("443")


# subdomain brute... it is really slow and only 
# checks if the domain returns status `200`.
sd = Snackhack2::Subdomains.new

sd.site = "https://abc.com"

sd.brute

# This is faster than the `brute` method..
# this uses Async::HTTP 

sd2 = Snackhack2::Subdomains2.new
sd2.site = "https://abc.com"

sd2.run