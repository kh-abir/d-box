require 'rails_helper'
require_relative '../support/devise'

RSpec.describe HomeController, type: :controller do

  describe "index" do
    it 'should render home index page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template("index")
    end
  end



end