require './lib/snackHack2'
#require "snackhack2"

=begin
tlds.site = "dropbox.com"
new_tlds = []
tlds.remove_letters.each do |o|
  tlds.site = o 
  new_tlds <<  tlds.change_tld
end
p new_tlds=
=end
=begin
def combo_squatting(site)
  tlds = Snackhack2::PhishingTlds.new
  tlds.site = sitei9
end
p tlds.combosquatting
=end
=begin
tlds.site = "google.com"
new_tlds = []
tlds.remove_letters.each do |o|
  tlds.site = o 
  new_tlds <<  tlds.change_tld
end
p new_tlds
=end


def generate_all(t, site)
  
  t.site = site

  generated_domains = t.combosquatting
  Snackhack2::file_save(t.site, "combosquatting", generated_domains.join("\n"), ip: false, host:false)

  changed_tld = t.change_tld
  Snackhack2::file_save(t.site, "tld_changed", change_tld.join("\n"), ip: false, host:false)

  letters_removed = t.remove_letters
  Snackhack2::file_save(t.site, "letters_removed", letters_removed.join("\n"), ip: false, host:false)
end

def combine(t, site)
  new_domains = ""
  t.site = site

  generated_domains = t.combosquatting
  
  changed_tld = t.change_tld
  
  letters_removed = t.remove_letters

  idn = t.idn_homograph

  new_domains += generated_domains.join("\n")
  new_domains += "\n=======================================\n"
  new_domains += changed_tld.join("\n")
  new_domains += "\n=======================================\n"
  new_domains += letters_removed.join("\n")
  new_domains += "\n=======================================\n"
  new_domains += idn.join("\n")
  new_domains += "\n=======================================\n"

  Snackhack2::file_save(t.site, "phishing_domains", new_domains, ip: false, host:false)
end

t = Snackhack2::PhishingTlds.new
t.site = "google.com"
t.combosquatting.each do |a|
  puts a
end
#t.remove_letters