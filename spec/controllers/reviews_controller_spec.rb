require 'rails_helper'
require 'support/devise'
require 'support/factory_girl'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create :user }
  let(:book) { create :book }
  let(:valid_attributes) { attributes_for :review }
  let(:valid_session) { {} }

  describe 'POST #create' do
    context 'when user is a guest' do
      it 'redirects to login page' do
        post :create, params: { book_id: book.id, review: valid_attributes },
                      session: valid_session
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'when user is signed in' do
      before { sign_in user }

      it 'creates a new Review' do
        expect {
          post :create, params: { book_id: book.id, review: valid_attributes },
                        session: valid_session
        }.to change(Review, :count).by(1)
      end

      it 'redirects to Book url' do
        post :create, params: { book_id: book.id, review: valid_attributes },
                      session: valid_session
        expect(response).to redirect_to book_url(book)
      end
    end
  end
end
