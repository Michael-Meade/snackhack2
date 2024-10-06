require './lib/snackHack2'

print("Enter URL ( with https:// ):")
url = "https://drrajatgupta.com"
Snackhack2::WordPress.new(url).yoast_seo

