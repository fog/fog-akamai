# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fog/akamai/version'

Gem::Specification.new do |spec|
  spec.name          = 'fog-akamai'
  spec.version       = Fog::Akamai::VERSION
  spec.authors       = ['Calin']
  spec.email         = ['calinoiu.alexandru@agilefreaks.com']
  spec.license       = 'MIT'

  spec.summary       = "Module for 'fog' gem to support Akamai"
  spec.description   = 'This library can be used as a module for `fog` or as standalone provider
                        to use Akamai'
  spec.homepage      = 'https://github.com/alexandru-calinoiu/fog-akamai'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'minitest-reporters', '~> 1.1'
  spec.add_development_dependency 'test-unit', '~> 3.1'
  spec.add_development_dependency 'webmock', '~> 1.22'
  spec.add_development_dependency 'rubocop', '~> 0.49'
  spec.add_development_dependency 'timecop', '~> 0.8.0'

  spec.add_dependency 'fog-core',  '~> 1.27'
  spec.add_dependency 'fog-json',  '~> 1.0'
  spec.add_dependency 'fog-xml',   '~> 0.1'
end
