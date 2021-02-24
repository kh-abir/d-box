require 'rails_helper'

RSpec.describe Category, type: :model do

  category = FactoryBot.create(:category)
  FactoryBot.create(:sub_category, :category_id => Category.last.id)
  FactoryBot.create(:product, :category_id => Category.last.id, :sub_category_id => SubCategory.last.id)

  context "creation" do
    it "has been cancelled due to error" do
      expect(category.title).not_to be_blank
      expect(category.id).not_to eq(nil)
    end
  end

  context "update" do
    it "has been cancelled due to error" do
      category.update(:title => "UpdateTestCategory")
      expect(category.id).to be > (0)
      expect(category.title).not_to be_blank
    end
  end
end
