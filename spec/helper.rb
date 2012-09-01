unless ENV['CI']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'spec'
  end
end

require 'livelyfeed'
require 'rspec'
require 'stringio'
require 'tempfile'
require 'timecop'
require 'webmock/rspec'

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end