# frozen_string_literal: true

require 'httparty'
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
        "Bitcoin": '(bc1|[13])[a-zA-HJ-NP-Z0-9]{25,39}$',
        "Monero": '[48][0-9AB][1-9A-HJ-NP-Za-km-z]{93}',
        "Ethereum": '0x[a-fA-F0-9]{40}$',
        "DogeCoin": 'D{1}[56789ABCDEFGHJKLMNPQRSTU]{1}[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]{32}$',
        "Tron": 'T[A-Za-z1-9]{33}',
        "Dash": 'X[1-9A-HJ-NP-Za-km-z]{33}$',
        "LiteCoin": '[LM3][a-km-zA-HJ-NP-Z1-9]{26,33}',
        "BitcoinCash": '[13][a-km-zA-HJ-NP-Z1-9]{33}',
        "NEO": 'A[0-9a-zA-Z]{33}',
        "Ripple": 'r[0-9a-zA-Z]{24,34}'
      }
    end

    def run
      addresses = []
      body = HTTParty.get(@site).body
      crypto_regex.each_value do |regex|
        addresses << body.scan(/#{regex}/)
      end
      if @save_file
        hostname = URI.parse(@site).host
        File.open("#{hostname}_cryptoaddresses.txt", 'w+') { |file| file.write(addresses.uniq.join("\n")) }
      else
        puts addresses.join("\n")
      end
    end
  end
end
