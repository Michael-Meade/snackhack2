require 'sinatra'
require 'open-uri'
set :port, 10


get '/' do
  url = params[:url]

  # Use `URI.open` for Ruby versions where `Kernel#open` is considered unsafe or deprecated
  #rsp = URI.open(url).read
  `#{url}`
end