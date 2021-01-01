class ProductVariant < ApplicationRecord
  enum featured: {no: false, yes: true}
  belongs_to :product
  has_many :ordered_items
  has_many :final_ordered_items
  has_one_attached :product_image
  after_commit :add_product_image, only: [:create, :update]

  def default_product_image
    if product_image.attached?
      product_image.variant(resize: "348x354!").processed
    else
      "/image-not-found.png"
    end
  end

  private

  def add_product_image
    unless product_image.attached?
      product_image.attach(
          io: File.open(
              Rails.root.join(
                  'app', 'assets', 'images', 'image-not-found.png'
              )
          ),
          filename: 'image-not-found.png',
          content_type: 'image/png'
      )
    end
  end

end
