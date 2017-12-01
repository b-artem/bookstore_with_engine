require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'

RSpec.describe BooksController, type: :controller do
  let(:book) { create :book }
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to have_http_status 200
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: book.id }, session: valid_session
      expect(response).to have_http_status 200
    end
  end
end
