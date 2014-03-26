# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_catalog_solr'
  s.version     = '2.0.8'
  s.summary     = 'TODO: Add gem summary here'
  s.description = 'TODO: Add (optional) gem description here'
  s.required_ruby_version = '>= 1.9.3'

  # s.author    = 'You'
  # s.email     = 'you@example.com'
  # s.homepage  = 'http://www.spreecommerce.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'sunspot_rails', '~> 2.1.0'

end
