class NotificationsMailer < ActionMailer::Base
  helper :application

  default from: SETTINGS["mailer"]["from"]
  default to:   SETTINGS["mailer"]["to"]

  def new_message message
    @message = message
    mail(subject: message.subject)
  end

  def new_comment comment
    @comment = comment
    mail(subject: "Новый комментарий")
  end
end
