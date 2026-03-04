require_relative '../lib/snackHack2'
hi = Snackhack2::HostInjection.new
hi.old_host_ip = "127.0.0.1"
hh = hi.test

