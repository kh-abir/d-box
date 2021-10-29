require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Admin::OrdersController, type: :controller do

  describe "index" do
    login_admin
    it 'should render ' do
      get :index
      expect(response).to render_template("index")
    end
  end

end