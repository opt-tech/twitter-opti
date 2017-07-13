require 'rails_helper'

RSpec.describe FollowersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #get_followers" do
    it "returns http success" do
      get :get_followers
      expect(response).to have_http_status(:success)
    end
  end

end
