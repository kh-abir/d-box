require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Admin::OrdersController, type: :controller do

  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe "index" do
    login_admin
    it 'should render ' do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "show" do
    login_admin
    it 'should render order show page' do
      get :show, params: {id: Order.last.id}
      expect(response).to render_template("show")
    end
  end

  describe "edit" do
    login_admin
    it 'should render the orders edit page' do
      get :edit, params: {id: Order.last.id}
      expect(response).to render_template("edit")
    end
  end

  describe "update" do
    it 'should be successful' do
      put :update, params: {id: Order.last.id}
      Order.last.reload
      expect(response).to be_successful
    end
  end

  describe "destroy" do
    login_admin
    it 'should be successful' do
      delete :destroy, params: { id: Order.last.id }
      expect(response).to redirect_to("where_i_came_from")
    end
  end
end