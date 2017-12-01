class UserMailer < Devise::Mailer
  default template_path: 'devise/mailer'
  default from: 'bookstore-notifications@example.com'

  layout 'mailer'
end
