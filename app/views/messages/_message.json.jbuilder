json.extract! message, :id, :text, :username, :created_at, :updated_at
json.url message_url(message, format: :json)
