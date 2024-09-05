module Snackhack2
	class ListUsers
		attr_accessor :user

		def initialize
			@user = user
		end
		def linux
			`cat /etc/passwd`.split("\n").each do |l|
				puts l.split(":")[0]
			end
		end
		def windows
			puts `net users`
		end
		def windows_search_user
			puts `net user #{@user}`
		end
	end
end