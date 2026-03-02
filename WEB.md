#### Web

- [WordPress](#wordpress)
- [Getting Server Header](#getting-server-header)
  * [cURL](#curl)
  * [Cloudflare](#cloudflare)
  * [Cloudfront](#cloudfront)
  * [Detect Headers](#detect-headers)
- [Robots.txt](#robotstxt)
  * [Disallow](#disallow)
  * [Allow](#allow)
- [Google Analytics](#google-analytics)
- [Get site's CERT Hash](#get-site-s-cert-hash)
- [Get ALL the links of a site](#get-all-the-links-of-a-site)
- [Get site's Meta Data](#get-site-s-meta-data)
- [Get a site's sitemap.xml](#get-a-site-s-sitemapxml)
- [Get a site's DNS records](#get-a-site-s-dns-records)
  * [A records](#a-records)
  * [Nameserver records](#nameserver-records)
  * [SOA records](#soa-records)
  * [TXT records](#txt-records)
  * [aaaa records](#aaaa-records)
  * [hinfo records](#hinfo-records)
  * [Mx records](#mx-records)
- [Get HTML comments](#html-comments)
- [Get Phone Number](#phone-number)
- [Host Injection](#host-injection)
  * [Host IP](#host-ip)
  * [Double Host IP](#double-host-ip)
  * [X Forward](#x-forward)
- [Tomcat](#tomcat)
- [IP Lookup](#ip-lookup)

## WordPress
Detects if the website uses WordPress. Will give it a score based on if WordPress attributes are found.

## Getting Server Header
Most web servers display a header in each request that includes the 'brand' of server. This can be
changed or ignored. But the class will use a handful of different techniques like using:

- cURL
- HTTP GET request
- Cloudfront
- Cloudflare
- TCP

It will also detect if the site is using the following Web Servers:

- Apache2
- nginx

```ruby
bg = Snackhack2::BannerGrabber.new
bg.site = "https://abc.com"
bg.run
```
### cURL

Uses cURL.

```ruby
bg = Snackhack2::BannerGrabber.new
bg.site = "https://abc.com"
bg.curl
```

### Detect Headers

Will make a get request and print out the headers that are returned. 

```ruby
bg = Snackhack2::BannerGrabber.new
bg.site = "https://abc.com"
bg.detect_header(return_status: false)
```
### Cloudflare

```ruby
bg = Snackhack2::BannerGrabber.new
bg.site = "https://abc.com"
bg.cloudflare
```

### Cloudfront
```ruby

bg = Snackhack2::BannerGrabber.new
bg.site = "https://abc.com"
bg.cloudfront

```


## Robots.txt
A site uses `robots.txt` to tell honest web site crawlers what they can and cannot crawl. The `allowed` section in the text file
tells honest web crawlers that they can crawl that part of the site. The `disallow` tells honest crawlers what they cannot crawl. 

The thing is that theres nothing from stopping a dishonest crawler from crawling entries in the `disallowed` section. 

This piece of code will gather all the disallowed and the allowed into on text. Sometimes you can find stuff you shouldnt in 
the robots.txt file.. All you need to do is add `/robots.txt` to the end of the site. 

```ruby
url = "https://abc.com"
r = Snackhack2::Robots.new(url)
r.run

```

### Disallow
Only show the disallowed entries to `robots.txt`. Will only show if the site returns a `200` status code when a single GET Request is made to it. 

```ruby
url = "https://abc.com"
r = Snackhack2::Robots.new(url)
r.disallow_robots.each do |da|
  puts da
end
```
### Allow

Only show the allowed entries to `robots.txt`. Will only show if the site returns a `200` status code when a single GET Request is made to it. 

```ruby
url = "https://abc.com"
r = Snackhack2::Robots.new(url)
r.allow_robots.each do |da|
  puts da
end
```
## Google Analytics 

Google Analytics is a piece of code in the site that allows the site owner to see the amount of 
traffic a site is getting, where the users visit on the website. A website might re-use the same google code on multiple sites.

```ruby
ga = Snackhack2::GoogleAnalytics.new

ga.site = "https://abc.com"
ga.run
```

## Get site's CERT Hash

This class will get the hash of the SSL cert the site i using. It could be used to find other sites that are using the same 
cert. 

```ruby
ssl =  Snackhack2::SSLCert.new

ssl.site = "https://google.com"
ssl.get_cert
```

## Get ALL the links of a site

Saves all the links in a site to a file. But it can also be used to print out the links instead of saving them in a file.
The saved file will be like this format: `abc.com_links.txt`


```ruby
sl = Snackhack2::WebsiteLinks.new

sl.site = "https://abc.com"
sl.run
```

## Get site's Meta Data

A site has a meta data tag to help with SEO which is a way for search engines to understand what the site does. 

```ruby
meta = Snackhack2::WebsiteMeta.new
meta.site = "https://abc.com"
meta.run

puts "[+] Getting a website's META descriptio\n".red
meta.description
```

## Get a site's sitemap.xml 

This gets a site's sitemap.xml file which is a xml file of URLS that the site has. Used by search engines to better index the site


```ruby
puts "[+] Getting a website's site.xml\n".red

xml = Snackhack2::SiteMap.new
xml.site = "https://michaelmeade.org"
xml.run

```

## Get a site's DNS records

### A records

```ruby
dns = Snackhack2::Dns.new
dns.site = "abc.com"
puts "A Record: "
dns.a.each do |a|
	puts a
end
```

### Nameserver records

```ruby
dns = Snackhack2::Dns.new
dns.site = "abc.com"

puts "NamerServer: "
dns.nameserver.each do |ns|
	puts ns
end
```

### SOA records

```ruby
dns = Snackhack2::Dns.new
dns.site = "abc.com"
puts "SOA: "
dns.soa.each do |s|
	puts s
end
```

### TXT records

```ruby
dns = Snackhack2::Dns.new
dns.site = "abc.com"
puts "TXT: "
dns.txt.each do |s|
	puts s
end
```

### aaaa records

```ruby
dns = Snackhack2::Dns.new
dns.site = "abc.com"
puts "AAAA: "
dns.aaaa.each do |s|
	puts s
end
```

### hinfo records

```ruby
dns = Snackhack2::Dns.new
dns.site = "abc.com"
puts "hinfo: "

dns.hinfo.each do |s|
	puts s
end
```

### Mx records 

```ruby
dns = Snackhack2::Dns.new
dns.site = "abc.com"
puts "MX: "
dns.mx.each do |s|
	puts s
end
```

## HTML Comments

This class will make a GET request to the site and display any comments in the source code.

```ruby
c = Snackhack2::Comments.new
c.site = "https://abc.com"
c.run
```
## Phone Numbers

This class has two methods, `run` & `spider`. The `spider` method will crawl each of the website's pages. While the 
`run` method will just send a GET request to the side and use a handful of regexs to extract the phone numbers. 


```ruby

d = Snackhack2::PhoneNumber.new
d.site = "https://www.hardin.kyschools.us/schools-1/school-phone-numbers"

d.run

d.spider
```

## Host Injection


### Host IP

```ruby
hi = Snackhack2::HostInjection.new

hi.site = "http://127.0.0.1:4567/admin"
hi.old_host_ip = "172.28.170.34"
hi.new_host_ip = "192.168.1.100"

#a.host_ip
#a.double_host_ip
hi.x_forwarded
```

### Double Host IP

```ruby
hi = Snackhack2::HostInjection.new

hi.site = "http://127.0.0.1:4567/admin"
hi.old_host_ip = "172.28.170.34"
hi.new_host_ip = "192.168.1.100"

a.double_host_ip
```

### X Forward

```ruby
hi = Snackhack2::HostInjection.new

hi.site = "http://127.0.0.1:4567/admin"
hi.old_host_ip = "172.28.170.34"
hi.new_host_ip = "192.168.1.100"

hi.x_forwarded
```

## Tomcat


```ruby


tc = Snackhack2::TomCat
tc.run
``` 

## IP Lookup

```ruby
require_relative '../lib/snackHack2'
ip   = Snackhack2::IpLookup.new

ip.site = "abc.com"

ip.run

```