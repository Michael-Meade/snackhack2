require "httparty"
require 'uri'
module Snackhack2
    class CryptoExtractWebsite
        attr_accessor :save_file
        def initialize(site, save_file: true)
            @site = site
            @save_file = save_file
        end
        def crypto_regex
            {
                "Bitcoin": '^(bc1|[13])[a-zA-HJ-NP-Z0-9]{25,39}$',
                "Monero": '[48][0-9AB][1-9A-HJ-NP-Za-km-z]{93}',
                "Ethereum": '^0x[a-fA-F0-9]{40}$',
                "DogeCoin": '^D{1}[56789ABCDEFGHJKLMNPQRSTU]{1}[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]{32}$',
                "Tron": 'T[A-Za-z1-9]{33}'
            }

        end
        def run
            addresses = []
            body = HTTParty.get(@site).body
            crypto_regex.each do |name, regex|
                addresses << body.scan(/#{regex}/)
            end

        hostname = URI.parse(@site).host
        File.open("#{hostname}_cryptoaddresses.txt", 'w+') { |file| file.write(addresses.uniq.join("\n")) } if @save_file 
        end
    end
end