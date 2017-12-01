require 'rails_helper'
require 'support/factory_girl'
require 'support/devise'

shared_examples 'latest books' do
  background do
    create_list(:book, 5)
    allow(Book).to receive(:best_seller).and_return(Book.first)
    allow_any_instance_of(Book).to receive_message_chain('images.[].image_url.file.url')
      .and_return("https://example.com/image.jpg")
    visit home_index_path
  end

  scenario 'displays latest 3 books, added onto website' do
    latest = Book.order('created_at DESC').limit(3)
    within '.carousel-inner' do
      expect(page).to have_content(latest.first.title)
      expect(page).to have_content(latest.second.title)
      expect(page).to have_content(latest.third.description[0..20])
    end
  end

  scenario 'does not display latest 4th book, added onto website' do
    within '.carousel' do
      expect(page).not_to have_content(Book.order('created_at DESC')
                                            .fourth.title)
    end
  end

  context 'when user flips the slide' do
    scenario 'next slide is shown', js: true do
      latest = Book.order('created_at DESC').limit(2)
      within '.carousel-inner > .item.active' do
        expect(page).to have_content(latest.first.title)
      end
      page.find('a.right.carousel-control').click
      within '.carousel-inner > .item.active' do
        expect(page).to have_content(latest.last.title)
      end
    end
  end

  context 'when user clicks Buy now button' do
    scenario 'adds chosen book to the cart', js: true do
      within '.carousel-inner > .item.active' do
        click_button(I18n.t('home.latest_book.buy_now'))
      end
      wait_for_ajax
      expect(Cart.first.line_items.first.book).to eq Book.order('created_at DESC').first
    end
  end
end

feature 'Home page' do
  feature 'latest books' do
    context 'when user is a guest' do
      it_behaves_like 'latest books'
    end

    context 'when user is logged in' do
      let(:user) { create(:user) }
      background { sign_in user }
      it_behaves_like 'latest books'
    end
  end
end
