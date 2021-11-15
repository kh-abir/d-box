class ProductVariant < ApplicationRecord
  enum featured: {no: false, yes: true}
  belongs_to :product
  has_many :ordered_items
  has_many :discounts, as: :discountable
  has_many :notifications
  has_many_attached :product_images
  after_commit :add_default_image, only: [:create, :update]
  after_update_commit :product_back_in_stock

  def product_back_in_stock
    if in_stock_before_last_save.zero?
      self.notifications.each { |item| ProductMailer.send_product_back_in_stock_notification(item.user_id, item.product_variant_id).deliver_later }
      self.notifications.all.delete_all
    end
  end

  def thumbnail(input)
    self.product_images[input].variant(resize: '80x80!').processed
  end

  def tile_photo(input)
    self.product_images[input]
  end

  def final_price
    product = self.product
    category = product.category

    if product.has_valid('Discount')
      price = product.discount_price(self)
    elsif category.has_valid('Discount')
      price = category.discount_price(self)
    else
      price = self.price
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
