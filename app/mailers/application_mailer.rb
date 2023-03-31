class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('views.app_title')
  layout "mailer"
end
