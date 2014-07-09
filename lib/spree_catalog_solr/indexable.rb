module SpreeCatalogSolr
  module Indexable
    def self.included(base)
      base.class_eval do
        extend MakeItIndexable
        include Methods
      end
    end

    module MakeItIndexable
      def make_me_indexable
        searchable(auto_index: false, auto_remove: false) do
          integer :id, stored: true
          integer :taxon_ids, stored: true, multiple: true do
            taxons.map(&:id)
          end

          double :price, stored: true

          text :name, stored: true
          text :description, stored: true
          string :slug, stored: true
          text :meta_description, stored: true
          string :primary_image, stored: true do
            images.first.attachment.url(:large)
          end
          string :primary_image_thumb, stored: true do
            images.first.attachment.url(:small)
          end
          string :taxons, stored: true, multiple: true do
            taxons.map(&:name)
          end

          integer :similar_products_ids, stored: true, multiple: true do
            related_products_ids(:similar)
          end

          string :master, stored: true do
            SpreeCatalogSolr::Utils.build_variant_hash(master).to_json
          end

          string :variants, stored: true do
            variants_and_option_values.collect do |v|
              SpreeCatalogSolr::Utils.build_variant_hash(v)
            end.to_json
          end

          string :option_types, stored: true do
            option_types.includes(:option_values).collect do |option_type|
              {
                  id: option_type.id,
                  name: option_type.name,
                  presentation: option_type.presentation,
                  position: option_type.position,
                  option_values: option_type.option_values
              }
            end.to_json
          end

          string :product_properties, stored: true do
            product_properties.collect do |property|
              {
                  id: property.id,
                  name: property.property.name,
                  value: property.value
              }
            end.to_json
          end

          SpreeCatalogSolr::Config[:extra_fields].each do |field|
            send field[:type], field[:name], stored: true
          end

        end
      end
    end

    module Methods
      def related_products_ids(relation_type_name)
        []
      end
    end
  end
end
