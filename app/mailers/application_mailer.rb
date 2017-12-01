class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@bookstore-artem.herokuapp.com'
  layout 'mailer'
end
