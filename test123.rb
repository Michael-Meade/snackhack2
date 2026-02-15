require 'httparty'
r = HTTParty.get("http://127.0.0.1:10/?url=http://localhost:8080")
puts r.code