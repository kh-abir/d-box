class ProductVariant < ApplicationRecord
  include ApplicationHelper
  enum featured: {no: false, yes: true}
  belongs_to :product
  has_many :ordered_items
  has_many :final_ordered_items
  has_many :discounts, as: :discountable
  has_many_attached :product_images
  after_commit :add_default_image, only: [:create, :update]
  def thumbnail input
    self.product_images[input].variant(resize: '80x80!').processed
  end

  def final_price
    if has_valid_discount(self.product)
      price = discount_price(self.product,self)
    elsif has_valid_discount(self.product.category)
      price = discount_price(self.product.category,self)
    else
      price = nil
    end
    price
  end


  private

  def add_default_image
    unless product_images.attached?
      product_images.attach(
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
