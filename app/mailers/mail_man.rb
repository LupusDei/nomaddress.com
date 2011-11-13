class MailMan < ActionMailer::Base
  default :from => "mail@nomaddress.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mail_man.confirmation.subject
  #
  def confirmation(user)
    @user = user
    mail :to => user.email, :subject => "NomAddress: Sign-up Confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mail_man.three_week_reminder.subject
  #
  def three_week_reminder
    @greeting = "Hi"

    mail :to => "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mail_man.two_week_reminder.subject
  #
  def two_week_reminder
    @greeting = "Hi"

    mail :to => "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mail_man.last_minute_reminder.subject
  #
  def last_minute_reminder
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
end
