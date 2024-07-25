# Snackhack2

![SnackHack2 Hacking Tools](https://i.imgur.com/8k7YH2N.png)


### What is SnackHack?

A collection of scripts that could be used to aid in hacking or performing recon on a taraget. The idea of this project is to take techniques learned in college to get experience and a better understanding of the techniques used to perform recon & hacking. 
Originally this idea was apart of my senior project but I had to ditch the idea. 

## Banner Grabbing.

Banner grabbing is used to get information about a server or computer. This information could help the hacker determine if the server or service is vulnerable. This information could also be used to figure out how to best enumerate a service. 

## Extracting Emails & Phone Numbers.

Scraping Emails or phone numbers from a site could be used to attemp to Social Engineer a user from that site via email, phone or SMS. Not all phishing emails or texts contain miss spellings or improper grammar. Some common techniques used when writting phishing emails or messages include the following:

- Intimidation
- Scarcity
- Familiarity
- Trust
- Urgency
- Authority
- Consensus

These techniques work to manipulate the user to give information or perform a certain task like entering their password into a phishing page.

## Robots.txt & Sitemap.xml.

The Robots.txt file is used to by sites to tell web crawlers such as Google what paths to crawl and what paths to ignore. Not every crawler will honor the robots.txt file. The site's robots.txt file will include paths that they do not want to be crawled, we can use this information to possibly access paths will disclose sensitive information. It could also lead hackers to areas of the site that are not supposed to be viewed by unauthorized users. The sitemap.xml includes a list of URLs of a site. This helps Google and other search engines to be able to crawl links on a site. It is supposed to help with search ranking. 

When a site displays a cryptocurrency address on the site, the address could be used to discover more sites that are owned by site or even their financial situation due to the fact that some cryptocurrencies block chain are public. Cryptocurrencies like Bitcoin, DogeCoin and Litecoin block chains are public, meaning you can see the amount of coins owned by the address. Cryptocurrencies that have a public blockchain have blockchain explorers that can be used to see how much an address has. It can also be used to view the past transcations. 

Not all cryptocurrencies are public, cryptocurrenies like Monero have a private blockchain meaning that you CAN'T see how much a certain address has. 

## Website MetaData & Google Analytics.

Websites use the HTML meta tag to include information about the site that supposed to help in being ranked higher on a search engine. This information could also be used to figure out what software or even the software version. Finding the Google Analytics tag could aid a hacker to locate different sites that are probably owned by the same owner. 

## Port Scanning. 

Scanning the first thousand ports of a server or computer will help reveal the purposes of the server and might give the hacker a way into the computers internal network. If the server shows that port 22 is open, the hacker might be able to brute force the SSH server or figue out the version of the service and exploit a vulnerability. This feature will only scan TCP ports. Future versions might include a UDP ports.

## Enumerating Web Content Management Platforms.

Figuring out what plugins or the version of the Web content management platforms can aid the hacker in compromising the site. The information could also be used to gather information about the site owners such as the usernames which could be used to brute forced the login for a certain user. The disclosure of the version and other information could also be used by a hacker to attemp to exploit a vulnerablity. Information like the MySQL version could be used to get into the site's database where they might be able to dump the database and use the dump to login into the site which could give them complete control of the server. 

## Exploits.

Exploits can be used to gain unauthorized access to a server or computer. Currently Snackhack2 has an exploits for CVE-2023-3710, 
CVE-2018-11709 and CVE-2015-6522. `CVE-2018-11709` is a XSS exploit. While CVE-2023-3710 exploits a Command Injection vulnerabilities in printer web page. This could allow hackers access to the network. `CVE-2015-6522` allows remote attackers to execute arbitrary SQL commands in the WordPress plugin, wp-symposium.

## Post Exploitation.

After exploiting a vulnerability and gaining access to server, a hacker might want to hide their tracks. As of right of now there is only one post exploitaton feature in Snackhack. This feature will take a web server log and remove a certain IP and replace it with a randomly generated IP. This could be used to cover your tracks or as a anti forsenic method. 

## Installation

```ruby
gem install snackhack2
```

## Usage

## Detect Drupal

Like the wordpress feature, there is a drupal score. The higher the score the better chance the site is using Drupal. Each time Drupal is detected it increases the score by 10. The `.all` will run all the different Drupal tests. 

```ruby
d = Snackhack2::Drupal.new("https://physiologycore.umn.edu/")
# Find out how many users the site has.
d.user_brute
# This will run all the methods to detect Drupal.
d.all
# This will just run the drupal score method. This will also print out the version of Drupal. 
d.drupal_score
```

## IP Lookup

Get IP of a site using Nslookup and ping.

```ruby
Snackhack2::IpLookup.new("https://google.com").run
```
## Extract Emails from Website

By default @max_depth is set to four. This can be changed as seen below. This wil save the emails with the host name of the site
and the '_emails.txt'. For example: 'example.com_emails.txt'


```ruby
e = Snackhack2::Email.new("https://www.tupeloschools.com/leadership/staff-directory")
e.run

# set @max_depth to two
e.max_depth = 2
puts e.max_depth
```

## Web Server log cleaner

You supply a IP and the code will find all the traces of the ip in the web server Log file and replace it with a fake IP that is randomly generated . By default it reads from "/var/log/access.log", but that can be changed. It has to be ran with root.

```ruby
Snackhack2::WebServerCleaner.new('83.149.9.216').run
```

## WordPress

There is 7 different elements in an array. The code loops through each line of the source code of the page, checking for that element in the source. If it is found it adds
10 to the score. The higher the score the more likely it is a site with Wordpress.

```ruby
require "snackhack2"
wp = Snackhack2::WordPress.new("https://kinsta.com")
wp.run
```

Now get wordpress user's. This will save the users in a file with a similar name like this: google.com_users.txt. `wp_content_uploads` will check to see if there are any open directories. 

```ruby
wp = Snackhack2::WordPress.new("https://themeisle.com")
wp.users
# print out users instead of saving to file.
wp = Snackhack2::WordPress.new("https://themeisle.com", save_file: false)
wp.users

# you can also set it to false like this:
wp = Snackhack2::WordPress.new("https://themeisle.com")
wp.save_file = false

wp.users


## check to see if a site has wp-conent with open directories!
wp.wp_content_uploads

## Look at multiple sites for wordpress.

["https://google.com", "https://kinsta.com", "https://porchlightshop.com", "https://www.drrajatgupta.com"].each do |site|
    wp = Snackhack2::WordPress.new(site)
    puts "#{site}: "
    wp.run
    puts "\n"
end
```
## Links

Grab all the links in a site and save it in a file named `google.com_links.txt` By default `@save_file` is set as `true`. If set to false it will print out all the links.


```ruby
links = Snackhack2::WebsiteLinks.new("https://www.bleepingcomputer.com/news/security/signal-downplays-encryption-key-flaw-fixes-it-after-x-drama/")
links.run

# set @save_file as false
links.save_file = false

```
## Snackhack CLI

```ruby
ruby snackhack.rb -h
```



## Clean server version

This will remove all files that include all files that have `_severversion` in the file name. The `_serversversion` files are created by Snackhack2::curl. 

```ruby
Snackhack2::clean_serverversion
```

## Read server version files

This will read all files with `_serverversion` in the file name. This is used if serverversion is used on a bunch of sites that you need to check and read. 

```ruby
SnackHack::read_serverversion
```

## Port Scan

This uses multi thread to scan the first 1,000 ports and print the open ports. 

```ruby
tcp = Snackhack2::PortScan.new("167.71.98.134")
tcp.run
```

## Robots.txt

This reads the robots.txt file and tries both the disallow and allow item and test to see if they are valid.

```ruby
ip = Snackhack2::Robots.new("https://google.com", save_file: true)
puts ip.run
```

## Banner Grabber

Banner grabbing is when you get information about a computer system. This information can be used to gather what version of software or what OS the computer is running. This information could also be used to plan an attack or used to find a exploit for the version of the software. 

```ruby
bg = Snackhack2::BannerGrabber.new("https://google.com")
bg.run

## Usin cURL

bg.curl

## Just get server name 
bg.server


["https://google.com", "https://kinsta.com", "https://porchlightshop.com", "https://www.drrajatgupta.com"].each do |site|
    s = Snackhack2::BannerGrabber.new(site)
    puts s.curl
end
```

## Google Analytics

This could be used to find other sites on the web that uses the same g code

```ruby
ga = Snackhack::GoogleAnalytics.new("https://g-form.com")
ga.run
```

## Banner grabber with cURL

```ruby
bg = Snackhack2::BannerGrabber.new("https://google.com")
bg.curl
# .server will give you the website's server banner
bg.server
```
## Crypto Extrator

By default it @save_file is set by true. But can be changed to false as seen below. If set to false it will print it out. This will find crypto addresses displayed on websites and save them to a file or print them out. Currently it supports: BTC, DOGE, XMR, ETH, Tron, Ripple, Dash, NEO, BitcoinCash and LiteCoin

```ruby
ca = Snackhack2::CryptoExtractWebsite.new("https://www.coincarp.com/currencies/tron/richlist/")
puts ca.save_file
ca.save_file = false
puts ca.save_file
ca.run

ca.monero
ca.bitcoin
ca.litecoin
ca.dash
ca.stellar
ca.ethereum
ca.bitcoincash
ca.dogecoin
```

## Sitemap.xml

This class will try to see if a site has a sitemap.xml file. This could be used to find URLS that might be of intrest.

```ruby
sm = Snackhack2::SiteMap.new("https://google.com")
sm.run
```
## TomCat

This will visit `/docs/` which if the web server is running Tom Cat, it will parse the page and print out the TomCat version. 

```ruby
tc = Snackhack2::TomCat.new("https://recrutements-ec.univ-lille.fr")
tc.run
```

## Honeywell PM43

This will exploit CVE-2023-3710. By default it uses the `ls` command.  This can be changed as seen below. 

```ruby
s = Snackhack2::HoneywellPM43.new("http://81.84.149.129:80")

# The command can be changed as seen below. 
s.command = "id"
puts s.command
# This will run the exploit. and print out the command output.
s.run
```

## Phone Number Extractor

Get phone numbers from a site. Use the following command to install spidr

```ruby
 sudo gem install spidr
 ```

```ruby
wp = Snackhack2::PhoneNumber.new('https://pastebin.com/PgJuhznU')
wp.run

```

## Phone Number Web Spider

```ruby
pn = Snackhack2::PhoneNumber.new('https://utica.edu/people')
pn.spider
# will print the phone numbers instead of saving them to file
ph.save_file = false
```

## wpForo Forum <= 1.4.11 - Unauthenticated Reflected Cross-Site Scripting (XSS)

```ruby
wp = Snackhack2::WPForoForum.new("http://www.example.com")
wp.run
```

## WordPress Plugin WP Symposium 15.1 - 'get_album_item.php' SQL Injection

Get MySQL version. 

```ruby
wp = Snackhack2::WP_Symposium.new("https://example.com")
wp.run
```
## Website MetaData

```ruby
me = Snackhack2::WebsiteMeta.new('https://kinsta.com')
me.run
```

## Subdomains

Uses DNS to find subdomains & IPs

```ruby
sd = Snackhack2::Subdomains.new("https://ruby-lang.org")
sd.run
```

## Subdomains2

This uses HTTP instead of DNS to find subdomains. By default the subdomain list is located in the `\lib\snackhack2\lists\subdomains.txt` directory. 

```ruby
Snackhack2::Subdomains2.new("https://netflix.com").run
```

## SSH Brute

```ruby
Snackhack2::SSHBute.new("167.98.80.8").run
```
## Install needed gems

```ruby
gem install httparty
gem install spidr
```