class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@bookstore_with_engine.herokuapp.com'
  layout 'mailer'
end
