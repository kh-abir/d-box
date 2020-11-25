module ApplicationHelper


  def get_all_categories
     Category.all
  end

  def get_all_subcategories
    SubCategory.all
  end

end
