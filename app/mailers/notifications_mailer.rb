class NotificationsMailer < ActionMailer::Base
  helper :application

  default from: Settings.mailer.from
  default to:   Settings.mailer.to

  def new_message(message)
    @message = message
    mail subject: message.subject, reply_to: message.email
  end

  def new_comment(comment)
    @comment = comment
    mail subject: 'Новый комментарий'
  end
end
