# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mapa76/core/version'

Gem::Specification.new do |gem|
  gem.name          = "mapa76-core"
  gem.version       = Mapa76::Core::VERSION
  gem.authors       = ["Marcos Vanetta", "Damián Silvani"]
  gem.email         = ["marcosvanetta@gmail.com", "dsilvani@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
