require 'rails_helper'
require 'support/factory_girl'
require 'support/i18n'

feature 'Login' do
  let(:user) { create :user }
  let(:book) { create :book }
  background do
    allow(Book).to receive(:best_seller).and_return(book)
    allow_any_instance_of(Book).to receive_message_chain('images.[].image_url.file.url')
      .and_return("https://example.com/image.jpg")
    visit new_user_session_path
  end

  context 'when email and password are valid' do
    background { create_list(:book, 3) }
    scenario 'logs user in' do
      within 'form#new_user' do
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        click_button t('devise.sessions.new.sign_in')
      end
      expect(page).to have_text t('devise.sessions.signed_in')
      expect(page).not_to have_content t('devise.enter_email')
      expect(page).not_to have_content t('devise.password')
      expect(page).not_to have_button t('devise.sessions.new.sign_in')
    end
  end

  context 'when password is invalid' do
    scenario "doesn't log user in" do
      within 'form#new_user' do
        fill_in 'email', with: user.email
        fill_in 'password', with: (user.password + '1')
        click_button t('devise.sessions.new.sign_in')
      end
      expect(page).to have_text t('devise.failure.invalid').first
      expect(page).not_to have_text t('devise.sessions.signed_in')
      expect(page).to have_content t('devise.enter_email')
      expect(page).to have_content t('devise.password')
      expect(page).to have_button t('devise.sessions.new.sign_in')
    end
  end
end
