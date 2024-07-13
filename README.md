# Snackhack2

TODO: Delete this and the text below, and describe your gem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/snackhack2`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

```ruby
gem install snackhack2
```

## Usage

## WebServer cleaner

You supply a IP and the code will find all the traces of the ip in the Log file and replace it with a fake IP that is generated . By default it reads from "/var/log/access.log", but that can be changed. It has to be ran with root.

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

Now get wordpress users. This will save the users in a file with a similiar name like this: google.com_users.txt

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

```
## Link

Grab all the links in a site and save it in a file named `google.com_links.txt` By default `@save_file` is set as `true`. If set to false it will print out all the links

```ruby
links = Snackhack2::WebsiteLinks.new("https://www.bleepingcomputer.com/news/security/signal-downplays-encryption-key-flaw-fixes-it-after-x-drama/")
links.run

# set @save_file as false
links.save_file = false

```

## PortScan

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

```ruby
bg = Snackhack2::BannerGrabber.new("https://google.com")
bg.run
```

## Google Analytics

This could be used to find other sites on the web that uses the same g code

```ruby
ga = GoogleAnalytics.new("https://g-form.com")
ga.run
```

## Banner grabber with cURL

```ruby
bg = Snackhack2::BannerGrabber.new("https://google.com")
bg.curl
# .server will give you the website's server banner
bg.server
```
## CryptoExtrator

By default it @save_file is set by true. But can be changed to false as seen below. If set to false it will print it out. This will find crytoaddresses in website and save them to a file or print them out. Currently it supports: BTC, DOGE, XMR, ETH, Tron.

```ruby
ca = Snackhack2::CryptoExtractWebsite.new("https://www.coincarp.com/currencies/tron/richlist/")
puts ca.save_file
ca.save_file = false
puts ca.save_file
ca.run
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
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).
