module SpreeCatalogSolr
  class Filter

    def self.search
      Collection.new yield
    end

    class Collection
      include Enumerable
      extend Forwardable
      attr_reader :collection
      def_delegators :collection, :offset, :length, :total_entries, :total_pages, :current_page, :previous_page, :next_page, :empty?, :size, :per_page

      def_delegators :to_ary, :each, :map

      def initialize search
        @collection = search.hits
      end

      #helper needed by Kaminari
      def limit_value
        length
      end

      def to_ary
        @collection.map {|hit| ResultHit.new(hit) }
      end

      alias_method :to_a, :to_ary
    end

    class ResultHit
      attr_accessor :hit

      def initialize hit
        @hit = hit
      end

      def to_param
        @hit.stored(:id)
      end

      def method_missing(sym, *args, &block)
        @hit.stored(sym)
      end
    end
  end
end