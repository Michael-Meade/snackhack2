require_relative '../lib/snackHack2'
hi = Snackhack2::HostInjection.new
hi.site = "http://127.0.0.1:4567/host_injection_1"
hi.old_host_ip = "127.0.0.1"
hi.new_host_ip = "localhost"
hh = hi.test_all

