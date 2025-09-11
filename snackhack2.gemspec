# frozen_string_literal: true

require_relative 'lib/snackhack2/version'

Gem::Specification.new do |spec|
  spec.name = 'snackhack2'
  spec.version = Snackhack2::VERSION
  spec.authors = ['mike']
  spec.email = ['noway@lol.com']

  spec.summary = 'Get '
  spec.description = 'Bunch of Hacking tools'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  File.basename(__FILE__)
  spec.files = Dir.glob('lib/**/*', File::FNM_DOTMATCH)
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'httparty', '0.22.0'
  spec.add_dependency 'net-ssh'
  spec.add_dependency 'nokogiri', '1.16.7'
  spec.add_dependency 'spidr', '0.7.1'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
