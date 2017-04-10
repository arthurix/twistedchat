class MessagesController < ApplicationController
  before_action :messages, only: [:index]

  def index
    @message = Message.new
  end

  def create
    message = Message.new(message_params)
    message.username = current_user
    if message.save
      ActionCable.server.broadcast 'messages',
        message: message.text,
        user: message.username
      head :ok
    end
  end

  private
    def message_params
      params.require(:message).permit(:text, :username)
    end

    def messages
      @messages = [] #Message.all
    end
end
