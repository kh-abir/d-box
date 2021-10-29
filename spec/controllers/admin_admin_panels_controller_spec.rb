require 'rails_helper'
require_relative '../support/devise'

RSpec.describe Admin::AdminPanelsController, type: :controller do

  describe "index" do
    login_admin
    it 'should render admin dashboard page' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template("index")
    end
  end
  
  describe "reports" do
    login_admin
    it 'should be successful' do
      get :reports
      expect(response).to render_template("reports")
      expect(response).to be_successful
    end
  end

end