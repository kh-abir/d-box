class Banner < ApplicationRecord
  belongs_to :product, optional: true
  belongs_to :category, optional: true
  belongs_to :sub_category, optional: true
  has_one_attached :banner_image

  enum link_type: {without_link: 0, product: 1, sub_category: 2, category: 3}

  def get_product_variant(product_id)
    product = Product.find(product_id)
    return product.product_variants.first.id
  end

  def get_title(link_type, link_id)
    if link_type == 'category'
      category = Category.find(link_id)
      return category.title
    elsif link_type == 'sub_category'
      sub_category = SubCategory.find(link_id)
      return sub_category.title
    elsif link_type == 'product'
      product = Product.find(link_id)
      return product.title
    elsif link_type == 'without_link'
      return 'None'
    end
  end
end
