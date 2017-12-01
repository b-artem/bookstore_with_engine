require 'support/factory_girl'
require 'support/i18n'

describe 'devise/sessions/new.html.haml', type: :view do
  before :all do
    RSpec.configure do |config|
      config.mock_with :rspec do |mocks|
        mocks.verify_partial_doubles = false
      end
    end
  end

  after :all do
    RSpec.configure do |config|
      config.mock_with :rspec do |mocks|
        mocks.verify_partial_doubles = true
      end
    end
  end

  let(:user) { build :user }
  before do
    allow(view).to receive(:resource).and_return(user)
    allow(view).to receive(:resource_name).and_return(:user)
    allow(view).to receive(:devise_mapping).and_return(Devise.mappings[:user])
    render
  end

  it 'has Log in text' do
    expect(rendered).to have_text t('devise.sessions.new.sign_in')
  end

  it 'has Facebook login icon' do
    expect(rendered).to have_selector 'i.fa.fa-facebook-official'
  end

  it 'has new_user form' do
    expect(rendered).to have_selector 'form#new_user'
  end

  it 'has email field' do
    expect(rendered).to have_selector '#email'
  end

  it 'has password field' do
    expect(rendered).to have_selector '#password'
  end

  it 'has Forgot password link' do
    expect(rendered).to have_link t('devise.shared.forgot_password.forgot_your_password')
  end

  it 'has Remember me checkbox' do
    expect(rendered).to have_css 'span.checkbox-icon'
    expect(rendered).to have_text t('devise.sessions.new.remember_me')
  end

  it 'has Log in button' do
    expect(rendered).to have_button t('devise.sessions.new.sign_in')
  end

  it 'has Sign up link' do
    expect(rendered).to have_link t('devise.shared.links.sign_up')
  end
end
