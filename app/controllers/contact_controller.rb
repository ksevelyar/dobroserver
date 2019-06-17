# frozen_string_literal: true

class ContactController < ApplicationController
  skip_before_action :authorize

  def new
    @message = Message.new
    @meta_title = 'Обратная связь'
  end

  def create
    @message = Message.new(params[:message])

    if @message.valid?
      NotificationsMailer.new_message(@message).deliver_now
      redirect_to root_path, notice: 'Сообщение отправлено.'
    else
      flash.now.alert = @message.errors.full_messages.to_sentence
      render :new
    end
  end
end
