require 'rails_helper'
require_relative '../support/devise'

RSpec.describe OrdersController, type: :controller do

  context "new" do
    login_user
    it "should render new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  #
  # context "create" do
  #   it 'should redirect to cart index page' do
  #     expect(response).to redirect_to(cart_index_path)
  #   end
  # end
  #
  # context "show" do
  #   it "action rendered the orders show template successfully" do
  #     get :show
  #     expect(response).to render_template(:show)
  #   end
  # end

end