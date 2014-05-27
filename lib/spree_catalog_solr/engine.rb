module SpreeCatalogSolr
  class Engine < Rails::Engine
    isolate_namespace SpreeCatalogSolr
    engine_name 'spree_catalog_solr'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end

  class Config
    include Singleton

    attr_accessor :extra_fields

    def initialize
      extra_fields = []
    end

    # Config.setup {|config| config.extra_fields = {}}
    # Config[:extra_fields]
    def self.setup
      yield self.instance
    end

    def self.[] field
      instance.send(field)
    end

  end
end
