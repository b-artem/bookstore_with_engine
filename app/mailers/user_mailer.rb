class UserMailer < Devise::Mailer
  default template_path: 'devise/mailer'
  default from: 'bookstore-artem-with-engine-notifications@example.com'

  layout 'mailer'
end
