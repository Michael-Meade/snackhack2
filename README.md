# Snackhack2

TODO: Delete this and the text below, and describe your gem

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/snackhack2`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

```ruby
gem install snackhack2
```

## Usage

## WordPress
```ruby
require "snackhack2"
wp = Snackhack2::WordPress.new("https://kinsta.com")
wp.run
```

## PortScan
```ruby
tcp = Snackhack2::PortScan.new("167.71.98.134")
tcp.run
```

## Robots.txt

```ruby
ip = Snackhack2::Robots.new("https://google.com", save_file: true)
puts ip.run
```

## Banner Grabber
```ruby
bg = Snackhack2::BannerGrabber.new("https://google.com")
bg.run
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).
