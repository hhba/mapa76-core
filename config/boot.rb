#APP_ROOT = File.join(File.dirname(__FILE__), "..") + "/"
#$LOAD_PATH.unshift(APP_ROOT)

require "rubygems" unless defined?(Gem)
require "bundler/setup"

require "mapa76/core"
Mongoid.load!("config/mongoid.yml", :test)

#require "config/logger"
#Dir["#{APP_ROOT}/lib/mapa76/core/lib/**/*.rb"].sort.each { |file| require file }
#Dir["#{APP_ROOT}/lib/mapa76/core/model/**/*.rb"].sort.each { |file| require file }
