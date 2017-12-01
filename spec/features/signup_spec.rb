require 'rails_helper'
require 'support/factory_girl'
require 'support/i18n'

feature 'Signup' do
  let(:password) { Faker::Internet.password(8) }
  let(:book) { create :book }
  background do
    allow(Book).to receive(:best_seller).and_return(book)
    allow_any_instance_of(Book).to receive_message_chain('images.[].image_url.file.url')
      .and_return("https://example.com/image.jpg")
    visit new_user_registration_path
  end

  context 'when password confirmation valid' do
    scenario 'User registers successfully via register form' do
      create_list(:book, 3)
      allow_any_instance_of(User).to receive(:confirmed_at).and_return(Time.now - 1.hours)
      within 'form#new_user' do
        fill_in 'email', with: Faker::Internet.email
        fill_in 'password', with: password
        fill_in 'confirm-password', with: password
        click_button t('devise.registrations.new.sign_up')
      end
      expect(page).to have_text t('devise.registrations.signed_up')
      expect(page).not_to have_content t('devise.enter_email')
      expect(page).not_to have_content t('devise.password')
      expect(page).not_to have_button t('devise.registrations.new.sign_up')
    end
  end

  context 'when password confirmation invalid' do
    scenario 'User fails to register via register form' do
      within 'form#new_user' do
        fill_in 'email', with: Faker::Internet.email
        fill_in 'password', with: password
        fill_in 'confirm-password', with: (password + '1')
        click_button t('devise.registrations.new.sign_up')
      end
      expect(page).not_to have_text t('devise.registrations.signed_up')
      expect(page).to have_content t('devise.enter_email')
      expect(page).to have_content t('devise.password')
      expect(page).to have_button t('devise.registrations.new.sign_up')
    end
  end
end
