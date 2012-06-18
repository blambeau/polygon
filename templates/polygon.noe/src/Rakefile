$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))

desc %q{Regenerates CSS stylesheet} 
task :css do
  Dir.chdir(File.dirname(__FILE__)) do
    `cp -R design/stylesheets/* public/css/`
    `rm -rf public/css/*.less`
    `lessc design/stylesheets/*.less > public/css/style.css`
  end
end

desc %q{Run the website locally}
task :development do
  exec "ruby scripts/launch.rb development"
end

desc %q{Run all RSpec tests}
task :spec do
  require 'rspec'
  exit RSpec::Core::Runner.run(%w[-Ilib -Ispec --pattern=spec/**/test_*.rb --color .])
end
task :default => :spec
