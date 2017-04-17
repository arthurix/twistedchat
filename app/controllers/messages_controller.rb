class MessagesController < ApplicationController
  before_action :messages, only: [:index]

  def index
    @message = Message.new
  end

  def create
    message = Message.new(message_params)
    message.dialect = current_dialect
    message.username = current_user
    message.translated = message.translate
    if message.save
      publish message
    end
  end

  def activity
    register_user
  end

  private
    def message_params
      params.require(:message).permit(:text, :username, :status)
    end

    def messages
      @messages = Message.latest
      @users = UserActivity.where(status: 'activate')
    end

    def publish(message)
      ActionCable.server.broadcast('messages',
                                   message: message.translated,
                                   dialect: message.dialect,
                                   mentions: message.mentions,
                                   username: message.username)
      head :ok
    end

    def register_user
      activity = UserActivity.find_or_initialize_by(username: current_user)
      activity.dialect = current_dialect
      activity.status = message_params[:status]
      if activity.save
        ActionCable.server.broadcast('users', username: current_user,
                                     dialect: current_dialect,
                                     status: message_params[:status])
      end
      head :no_content
    end
end
