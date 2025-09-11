# frozen_string_literal: true

require 'httparty'
require 'spidr'
module Snackhack2
  class Email
    attr_accessor :max_depth

    def initialize(site, save_file: true, max_depth: 4)
      @site = site
      @save_file = save_file
      @max_depth = max_depth
    end

    attr_reader :max_depth

    def run
      found_emails = []
      Spidr.start_at(@site, max_depth: @max_depth) do |agent|
        agent.every_page do |page|
          body = page.to_s
          if body.scan(/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/)
            email = body.scan(/[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/).uniq
            found_emails << email if !email.include?(found_emails) && !email.empty?
          end
        end
      end
      Snackhack2.file_save(@site, 'emails', found_emails.uniq.join("\n")) if @save_file
    end
  end
end
