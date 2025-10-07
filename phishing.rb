require './lib/snackHack2'

ct = Snackhack2::PhishingDomains.new
ct.site = "blog.google.com"
new_domains = ct.check_domains


final_domains = []
cl = Snackhack2::ChangeLetters.new
new_domains.each do |d|
    cl.site = d
    final_domains << cl.similar_letters
end
final_domains.each do |d|
	puts d
end

p "blog.google" == "blog.google"

=begin
ct = Snackhack2::PhishingDomains.new
ct.site = "blog.google.com"
new_domains = ct.check_domains
p new_domains
=end