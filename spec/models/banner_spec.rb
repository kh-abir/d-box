# require 'rails_helper'
#
# RSpec.describe Banner, type: :model do
#   category_banner = Banner.create(:name => "TestCategoryBanner", :link_type => 3, :link_id => Category.count > 0 ? Category.last.id : 0)
#   subcategory_banner = Banner.create(:name => "TestSubcategoryBanner", :link_type => 2, :link_id => SubCategory.count > 0 ? SubCategory.last.id : 0)
#   product_banner = Banner.create(:name => "TestProductBanner", :link_type => 1, :link_id => Product.count > 0 ? Product.last.id : 0)
#   without_link_banner = Banner.create(:name => "TestWithoutLinkBanner", :link_type => 0, :link_id => "NULL")
#
#   context "creation" do
#     # it "of category type has been cancelled due to error" do
#     #   expect{Banner.all.where(:link_type => 3).last.id}.not_to eq(category_banner.id)
#     # end
#     it "of without link type has been cancelled due to error" do
#       expect{Banner.all.where(:link_type => 0).last.id}.not_to eq(without_link_banner.id)
#     end
#   end
# end

