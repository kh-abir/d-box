# require 'rails_helper'
#
# RSpec.describe Category, type: :model do
#   category = Category.create(:title => "TestCategory")
#
#   context "creation" do
#     it "has been cancelled due to error" do
#       expect(category.title).not_to be_blank
#       expect(category.id).not_to eq(nil)
#       expect(Category.last!).to eq(category)
#     end
#   end
#
#   context "update" do
#     it "has been cancelled due to error" do
#       category.update(:title => "UpdateTestCategory")
#       expect(category.id).to be > (0)
#       expect(Category.all.where(:id => category.id).count).not_to be > (1)
#       expect(category.title).not_to be_blank
#     end
#   end
# end
