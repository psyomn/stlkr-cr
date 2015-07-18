# -*- encoding: utf-8 -*-

require File.expand_path('../lib/stlkr/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "stlkr"
  gem.version       = Stlkr::VERSION
  gem.summary       = %q{watch different web pages for changes}
  gem.description   = %q{periodically checks for updates on sites}
  gem.license       = "MIT"
  gem.authors       = ["psyomn"]
  gem.email         = "lethaljellybean@gmail.com"
  gem.homepage      = "https://github.com/psyomn/stlkr#readme"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.10.5'
  gem.add_development_dependency 'rake', '~> 0.8'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'yard', '~> 0.8'

  gem.add_runtime_dependency 'libnotify', '~> 0.9.1'
  gem.add_runtime_dependency 'nokogiri', '~> 1.6.6.2'
  gem.add_runtime_dependency 'gtk2', '~> 2.2.5'
end
