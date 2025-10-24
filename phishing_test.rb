require './lib/snackHack2'
tlds = [".com", ".net", ".tv"]
t = Snackhack2::PhishingTlds.new
t.site = "google.com"
domains = ["google.com", "hackex.net", "ibama.com"]
lol = t.test
