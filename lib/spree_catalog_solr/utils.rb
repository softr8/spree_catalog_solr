module SpreeCatalogSolr
  class Utils
    class << self
      def build_images_array(variant)
        variant.images.collect do |image|
          {
              id: image.id,
              position: image.position,
              alt: image.alt,
              mini_url: image.attachment.url(:mini),
              small_url: image.attachment.url(:small),
              product_url: image.attachment.url(:product),
              large_url: image.attachment.url(:large),
              original_url: image.attachment.url(:original)
          }
        end
      end

      def build_variant_hash(variant)
        {
            id: variant.id,
            is_master: variant.is_master,
            options_text: variant.options_text,
            sku: variant.sku,
            position: variant.position,
            price: variant.price,
            slug: variant.slug,
            in_stock: variant.in_stock?,
            images: build_images_array(variant)
        }
      end
    end
  end
end
