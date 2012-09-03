# encoding: utf-8

require File.expand_path('../lib/livelyfeed/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Patrick Glandien"]
  gem.description = %q{A Ruby wrapper for the LivelyFeed API.}
  gem.email = ['patrick@livelyfeed.com']
  gem.files = %w(CHANGELOG.md LICENSE.md README.md Rakefile livelyfeed.gemspec)
  gem.files += Dir.glob("lib/**/*.rb")
  gem.files += Dir.glob("spec/**/*")
  gem.homepage = 'https://github.com/livelyfeed/livelyfeed'
  gem.name = 'livelyfeed'
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = %q{LivelyFeed API wrapper}
  gem.test_files = Dir.glob("spec/**/*")
  gem.version = Livelyfeed::Version

  gem.add_dependency 'faraday', '~> 0.8'
  gem.add_dependency 'multi_json', '~> 1.3'

  gem.add_development_dependency 'json'
  gem.add_development_dependency 'maruku'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'timecop'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'
end