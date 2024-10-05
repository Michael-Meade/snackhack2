require './lib/snackHack2'

print("Enter URL ( with https:// ):")
url = gets.chomp
Snackhack2::WordPress.new(url).authors