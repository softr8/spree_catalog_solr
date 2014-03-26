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
        end
      end
    end
  end
end