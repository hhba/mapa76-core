require "rubygems" unless defined?(Gem)
require "bundler/setup"

require "mapa76/core"
Mongoid.load!("spec/mongoid.yml", :test)


# Test dependencies
require "minitest/spec"
require "minitest/autorun"

begin
  require "turn/autorun"
rescue LoadError
end

require "factory_girl"
require "database_cleaner"


class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods

  FactoryGirl.find_definitions

  def setup
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
end


def data_path(filename)
  File.expand_path(File.join(File.dirname(__FILE__), "data", filename))
end
