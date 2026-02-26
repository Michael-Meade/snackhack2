require '../lib/snackHack2'

rc = Snackhack2::RubyComments.new
rc.file = "test_comments.txt"
rc.comments
rc.comment_block


puts "[+] Getting HTML comments\n".red
c = Snackhack2::Comments.new
c.site = "https://abc.com"
c.run