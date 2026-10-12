lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fog/akamai/version'

Gem::Specification.new do |spec|
  spec.name          = 'fog-akamai'
  spec.version       = Fog::Akamai::VERSION
  spec.authors       = ['Calin']
  spec.email         = ['calinoiu.alexandru@agilefreaks.com']
  spec.license       = 'MIT'

  spec.summary       = "Module for 'fog' gem to support Akamai"
  spec.description   = 'This library can be used as a module for `fog` or as standalone provider to use Akamai NetStorage'
  spec.homepage      = 'https://github.com/fog/fog-akamai'

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'source_code_uri' => spec.homepage,
    'changelog_uri' => "#{spec.homepage}/blob/master/CHANGELOG.md",
    'bug_tracker_uri' => "#{spec.homepage}/issues",
    'rubygems_mfa_required' => 'true'
  }

  spec.required_ruby_version = '>= 3.3'

  spec.files         = Dir['lib/**/*.rb', 'README.md', 'LICENSE.md', 'CHANGELOG.md']
  spec.require_paths = ['lib']

  spec.add_dependency 'fog-core', '~> 2.1'
  spec.add_dependency 'fog-xml',  '~> 0.1'
end
