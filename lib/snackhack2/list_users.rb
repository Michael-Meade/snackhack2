# frozen_string_literal: true

module Snackhack2
  class ListUsers
    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def linux
      `cat /etc/passwd`.split("\n").each do |l|
        puts l.split(':')[0]
      end
    end

    def windows
      puts `net users`
    end

    def windows_search_user
      puts `net user #{@user}`
    end

    def auto
      os = RUBY_PLATFORM
      if os.match?('linux')
        linux
      elsif os.match?('mingw') || os.match?(/mswin|msys|mingw|cygwin|bccwin|wince|emc/)
        windows
      end
    end
  end
end
