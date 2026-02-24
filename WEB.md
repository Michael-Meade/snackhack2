#### Web

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

## Google Analytics 

Google Analytics is a piece of code in the site that allows the site owner to see the amount of 
traffic a site is getting, where the users visit on the website. A website might re-use the same google code on multiple sites.

```ruby
ga = Snackhack2::GoogleAnalytics.new

ga.site = "https://abc.com"
ga.run
```