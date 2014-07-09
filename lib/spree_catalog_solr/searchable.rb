require 'sunspot'
module SpreeCatalogSolr
  module Searchable
    def self.included(base)
      base.class_eval do
        extend Sunspot::Rails::Searchable::ActsAsMethods
        extend SpreeCatalogSolr::Indexable::MakeItIndexable
        Sunspot::Adapters::DataAccessor.register(DataAccessor, base)
        Sunspot::Adapters::InstanceAdapter.register(InstanceAdapter, base)
        include SpreeCatalogSolr::Methods
      end
    end

    class InstanceAdapter < ::Sunspot::Adapters::InstanceAdapter
      def id
        @instance.id
      end
    end

    class DataAccessor < ::Sunspot::Adapters::DataAccessor
      def load(id)
      end

      def load_all(ids)
      end
    end
  end

end
