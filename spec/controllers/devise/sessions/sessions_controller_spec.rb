require 'support/devise'
require 'support/factory_girl'

describe Devise::SessionsController, type: :controller do
  let(:user) { create :user }
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'GET #new' do
    it "returns a success response" do
      get :new
      expect(response).to have_http_status 200
    end
  end
end
