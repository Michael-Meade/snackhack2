require './lib/snackHack2'
=begin
#e = Snackhack2::Email.new("https://hamesa.com/pto-news-puerto-rico-news-testing-schedule-car-show-sports/")
e.max_depth = 2
e.run

# set @max_depth to two
=end

es = Snackhack2::EmailSort.new
#es.gather_emails
es.remove_png