require 'rails_helper'
require_relative '../support/devise'

RSpec.describe CartController, type: :controller do

  describe "index" do
    login_user
    it 'should render cart index page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template("index")
    end
  end

end