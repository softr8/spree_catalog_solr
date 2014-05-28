module SpreeCatalogSolr
  class Config
    include Singleton

    attr_accessor :extra_fields

    def initialize
      @extra_fields = []
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
