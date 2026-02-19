require_relative '../lib/snackHack2'

bg = Snackhack2::BannerGrabber.new
bg.site = "100.33.33.33"

# uses tcp socket
#bg.get_tcp_info

bg.site = "https://abc.com"

# Get if server is using nginx...
puts "[+] Testing if site is using nginx... [+]"
bg.nginx
puts "\n\n\n{=============================================}\n\n\n"
# Using cURL to get headers
puts "[+] Using cURL to get the site's headers [+]"
bg.curl
puts "\n\n\n{=============================================}\n\n\n"

# Check if server is using apache
puts "[+] Testing if site is using Apache2... [+]"
bg.apache2

puts "\n\n\n{=============================================}\n\n\n"

# Check if server is running wordpress...
puts "[+] Testing if site is using wordpress... [+]"
bg.site = "https://krebsonsecurity.com"

bg.wordpress


# Checking for cloudflare headers
puts "[+] Checking for cloudflare headers! [+]\n\n\n"

bg.cloudflare

puts "\n\n\n{=============================================}\n\n\n"

# checking for cloudflare headers w/o printing them
puts "[+] Checking for cloudflare headers w/o printing [+]\n\n\n"
bg.site = "https://abc.com"
p bg.cloudflare(print_status: false)

puts "\n\n\n{=============================================}\n\n\n"

# Checking for cloudfront in the headers
puts "\n\n\n[+] Checking for cloudfront headers [+]\n\n\n"
bg.cloudfront

puts "\n\n\n{=============================================}\n\n\n"

# checking for cloudfront headers  w/o printing
# It will return the results in an array.
puts "\n\n\n[+] Checking for cloudfront headers w/o printing [+]\n\n\n"
p bg.cloudfront(print_status: false)

puts "\n\n\n{=============================================}\n\n\n"

# Detect the headers of the site it will return the hash
# by default 
puts "\n\n\n[+] Detecting headers with returning it [+]\n\n\n"
p bg.detect_header

puts "\n\n\n{=============================================}\n\n\n"

# Detect the headers will print out the headers
puts "\n\n\n[+] Checking for cloudfront headers with printing it [+]\n\n\n"

bg.detect_header(return_status: false)