class UserMailer < Devise::Mailer
  default template_path: 'devise/mailer'
  default from: 'bookstore_with_engine-notifications@example.com'

  layout 'mailer'
end
