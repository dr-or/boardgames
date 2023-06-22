class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.dig(:mail, :username)
  layout 'mailer'
end
