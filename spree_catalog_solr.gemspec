# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_catalog_solr'
  s.version     = '2.0.8'
  s.summary     = 'Connects Spree to a Solr-based product catalog'
  s.required_ruby_version = '>= 1.9.3'

  s.author      = 'Edwin Cruz'
  s.email       = 'edwin.cruz@crowdint.com'

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'sunspot_rails', '~> 2.1.0'

end
