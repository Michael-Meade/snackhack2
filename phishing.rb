require './lib/snackHack2'

tlds = Snackhack2::PhishingTlds.new
tlds.site = "google.com"
new_tlds = []
tlds.remove_letters.each do |o|
  tlds.site = o 
  new_tlds <<  tlds.change_tld
end
p new_tlds