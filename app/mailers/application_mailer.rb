class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@bookstore-artem-with-engine.herokuapp.com'
  layout 'mailer'
end
