module MessagesHelper

  def chat_side(username)
    (username == current_user) ? 'left' : 'right'
  end

  def time(created_at)
    created_at.strftime("%d/%b/%Y %H:%M:%S")
  end
end
