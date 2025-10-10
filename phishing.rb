require './lib/snackHack2'


=begin
tlds.site = "dropbox.com"
new_tlds = []
tlds.remove_letters.each do |o|
  tlds.site = o 
  new_tlds <<  tlds.change_tld
end
p new_tlds=
=end
tlds = Snackhack2::PhishingTlds.new
tlds.site = "google.com"
p tlds.combosquatting
=begin
tlds.site = "google.com"
new_tlds = []
tlds.remove_letters.each do |o|
  tlds.site = o 
  new_tlds <<  tlds.change_tld
end
p new_tlds
=end