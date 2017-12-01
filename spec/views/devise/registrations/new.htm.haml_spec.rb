require 'support/factory_girl'
require 'support/i18n'

describe 'devise/registrations/new.html.haml', type: :view do
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

  it 'has Sign Up text' do
    expect(rendered).to have_text t('devise.registrations.new.sign_up')
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

  it 'has confirm password field' do
    expect(rendered).to have_selector '#confirm-password'
  end

  it 'has Sign Up button' do
    expect(rendered).to have_button t('devise.registrations.new.sign_up')
  end

  it 'has Sign in link' do
    expect(rendered).to have_link t('devise.sessions.new.sign_in')
  end
end
