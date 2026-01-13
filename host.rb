require './lib/snackHack2'
=begin
Example of web server to test function



require 'sinatra'

get '/admin' do
	if request.host.eql?("192.168.1.100")
		"<b>YES</b>"
	else
		"<b>NO</b>"
	end 
end

=end
a = Snackhack2::HostInjection.new
a.site = "http://127.0.0.1:4567/admin"
a.old_host_ip = "172.28.170.34"
a.new_host_ip = "192.168.1.100"

#a.host_ip
#a.double_host_ip
a.x_forwarded