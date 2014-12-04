class ContactController < ApplicationController
  # skip_before_action :authorize
  layout "clean"

  def new
    @message = Message.new
    @meta_title = "Обратная связь"
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      NotificationsMailer.new_message(@message).deliver
      redirect_to root_path, notice: "Сообщение отправлено."
    else
      flash.now.alert = @message.errors.full_messages.to_sentence
      render :new
    end
  end
end
