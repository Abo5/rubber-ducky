require File.expand_path('lib/rubber-ducky/version', __dir__)

Gem::Specification.new do |spec|
  spec.name          = 'rubber-ducky'
  spec.version       = '1.0'
  spec.authors       = 'MAVEN'
  spec.email         = 'aszda33@gmail.com'
  spec.summary       = 'A Ruby library for encoding and decoding Rubber Ducky scripts.'
  spec.description   = 'This gem allows you to encode and decode Rubber Ducky scripts for penetration testing purposes.'
  spec.homepage      = 'https://github.com/Abo5/rubber-ducky'
  spec.license       = 'MIT'
  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.5.0'

  # Include all files from git tracking, excluding test, spec, and features
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  # Ensure all necessary files are included in the gem
  spec.files += Dir['README.md', 'LICENSE', 'CHANGELOG.md', 'lib/**/*.rb', 'lib/**/*.rake', 'rubber-ducky.gemspec', '.github/*.md', 'Gemfile', 'Rakefile', 'examples/*']

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Define runtime and development dependencies
  spec.add_runtime_dependency 'json', '~> 2.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
