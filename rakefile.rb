namespace "gems" do
  task :all do
    require "colorize"
    gemfile = Dir.glob("*.gem").each { |f| f }.shift
    if !gemfile.nil?
      if File.exist?(gemfile)
        puts "Deleting #{gemfile}...\n".red
        File.delete(gemfile)
        puts "Building gem...\n".red
        %x(gem build snackhack2.gemspec)
        puts "Pushing Gem...\n".red
        begin
          sh "gem push #{Dir.glob("*.gem").each { |f| f }.shift}"
        rescue
          puts "ERROR in Pushing...\n".red
        end
      end
    else
      puts "No gem file found..."
    end
  end
  task :push do
    require "colorize"
    gemfile = Dir.glob("*.gem").each { |f| f }.shift
    if !gemfile.nil?
      puts "Pushing Gem...\n".red
      begin
        sh "gem push #{gemfile}"
      rescue
        puts "ERROR in pushing gem...\n".red
      end
    end
  end
  task :build do
    gemspec = Dir.glob("*.gemspec").each { |f| f }.shift
    if !gemspec.nil?
      puts "Building gemspec...\n"
      sh "gem build #{gemspec}"
    else
      puts "NO gemspec found...\n"
    end
  end
end
