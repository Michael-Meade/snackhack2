# Snackhack2

### What is SnackHack?



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

Now get wordpress user's. This will save the users in a file with a similiar name like this: google.com_users.txt. `wp_content_uploads` will check to see if there are any open directories. 

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
## Link

Grab all the links in a site and save it in a file named `google.com_links.txt` By default `@save_file` is set as `true`. If set to false it will print out all the links.


```ruby
links = Snackhack2::WebsiteLinks.new("https://www.bleepingcomputer.com/news/security/signal-downplays-encryption-key-flaw-fixes-it-after-x-drama/")
links.run

# set @save_file as false
links.save_file = false

```
## Clean serverversion

This will remove all files that include all files that have `_severversion` in the file name. The `_serversversion` files are created by Snackhack2::curl. 

```ruby
Snackhack2::clean_serverversion
```

## Read serverversion files

This will read all files with `_serverversion` in the file name. This is used if serverversion is used on a bunch of sites that you need to check and read. 

```ruby
SnackHack::read_serverversion
```

## PortScan

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

## SSH Brute

```ruby
Snackhack2::SSHBute.new("167.98.80.8").run
```
## Install needed gems

```ruby
gem install httparty
gem install spidr
```