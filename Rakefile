require 'rake/testtask'
require 'bundler/gem_tasks'

# Task to run tests using RSpec
Rake::TestTask.new do |t|
  t.libs << "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end

# Task to install the gem locally
desc "Build and install the gem locally"
task :install do
  sh "gem build rubber-ducky.gemspec"
  sh "gem install rubber-ducky-#{Rubber::Ducky::VERSION}.gem"
end

# Task to run RuboCop for code linting
desc "Run RuboCop for code quality"
task :rubocop do
  sh "rubocop"
end

# Task to generate documentation using Yard
desc "Generate YARD documentation"
task :yard do
  sh "yard doc"
end

# Task to release the gem to RubyGems
desc "Release the gem to RubyGems"
task :release => [:install] do
  sh "gem push rubber-ducky-#{Rubber::Ducky::VERSION}.gem"
end

# Default task is to run tests
task :default => :test
