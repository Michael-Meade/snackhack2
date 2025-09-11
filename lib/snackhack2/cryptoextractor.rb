# frozen_string_literal: true

require 'httparty'
require 'uri'
module Snackhack2
  class CryptoExtractWebsite
    attr_accessor :save_file

    def initialize(site, save_file: true)
      @http = Snackhack2.get(site).body
      @site = site
      @save_file = save_file
    end

    def all
      addresses = []
      addresses << monero unless monero.nil?
      addresses << bitcoin unless bitcoin.nil?
      addresses << dash unless dash.nil?
      addresses << ethereum unless ethereum.nil?
      addresses << bitcoincash unless bitcoincash.nil?
      addresses << litecoin unless litecoin.nil?
      addresses << dogecoin unless dogecoin.nil?
      addresses << stellar unless stellar.nil?
      if @save_file
        Snackhack2.file_save(@site, 'cryptoaddresses', addresses.uniq.join("\n"))
      else
        puts addresses.join("\n")
      end
    end

    def monero
      @http.scan(/([48][0-9AB][1-9A-HJ-NP-Za-km-z]{93})/)
    end

    def bitcoin
      @http.scan(/(bc(0([ac-hj-np-z02-9]{39}|[ac-hj-np-z02-9]{59})|1[ac-hj-np-z02-9]{8,87})|[13][a-km-zA-HJ-NP-Z1-9]{25,35})/)
    end

    def dash
      @http.scan(/(X[1-9A-HJ-NP-Za-km-z]{33})/)
    end

    def stellar
      @http.scan(/(G[A-Z0-9]{55}$)/)
    end

    def litecoin
      @http.scan(/([LM3][a-km-zA-HJ-NP-Z1-9]{26,33})/)
    end

    def dogecoin
      @http.scan(/(D{1}[56789ABCDEFGHJKLMNPQRSTU]{1}[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]{32}$)/)
    end

    def ethereum
      @http.scan(/(0x[a-fA-F0-9]{40})/)
    end

    def bitcoincash
      @http.scan(/([13][a-km-zA-HJ-NP-Z1-9]{33})/)
    end
  end
end
