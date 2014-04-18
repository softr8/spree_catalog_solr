module SpreeCatalogSolr
  module Indexable
    def self.included(base)
      base.class_eval do
        extend MakeItIndexable
      end
    end

    module MakeItIndexable
      def make_me_indexable
        searchable(auto_index: false, auto_remove: false) do
          integer :id, stored: true

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

          string :variants, stored: true do
            ([master] + variants_and_option_values).inject({}) do |final, variant|
              final[variant.id] = {
                  option_text: variant.options_text,
                  is_master: true,
                  price: variant.price,
                  sku: variant.sku,
                  position: variant.position
              }
              final
            end.to_json
          end

          string :images, stored: true do
            (images + variant_images).inject([]) do |final, image|
              final << [
                  viewable_id: image.viewable_id,
                  viewable_type: image.viewable_type,
                  alt: image.alt,
                  position: image.position,
                  versions: {
                      mini: image.attachment.url(:mini),
                      small: image.attachment.url(:small),
                      product: image.attachment.url(:product),
                      large: image.attachment.url(:large),
                      original: image.attachment.url(:original)
                  }
              ]
              final
            end.flatten.to_json
          end

          string :product_properties, stored: true do
            product_properties.collect do |property|
              {
                  name: property.property.name,
                  value: property.value
              }
            end.to_json
          end

        end
      end
    end
  end
end