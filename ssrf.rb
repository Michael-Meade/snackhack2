# frozen_string_literal: true

require './lib/snackHack2'
sf = Snackhack2::SSRF.new
sf.site = 'http://localhost:9494/?url=SSRF'
sf.ssrf
