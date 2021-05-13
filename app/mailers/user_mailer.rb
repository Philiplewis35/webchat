class UserMailer < ApplicationMailer

  def notify_messages(user_email, weekly, since_last)
    @user_email = user_email
    @weekly = weekly
    @since_last = since_last
    mail(to: user_email, subject "Message summary")
  end
end
