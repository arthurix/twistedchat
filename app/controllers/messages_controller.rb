class MessagesController < ApplicationController
  before_action :messages, only: [:index]

  def index
    @message = Message.new
  end

  def create
    message = Message.new(message_params)
    message.dialect = session[:dialect]
    message.username = current_user
    message.translated = message.translate
    #if message.save
      publish message
    #end
  end

  private
    def message_params
      params.require(:message).permit(:text, :username)
    end

    def messages
      @messages = [] #Message.all
    end

    def publish(message)
      ActionCable.server.broadcast('messages',
        message: message.translated,
        user:    message.username)
      head :ok
    end
end
