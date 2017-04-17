class Message < ApplicationRecord
  scope :latest, -> { order(:created_at).last(100) }

  def translate
    dispatch.translate
  end

  def dispatch
    clazz ||= class_eval(dialect.to_s.capitalize)
    clazz.new(text, dialect)
  end

  def scanned_mentions
    text.scan(/@(#{User::USERNAME_REGEX})/).flatten
  end

  def mentions
    scanned_mentions.map do |username|
      UserActivity.active(username)
    end.compact
  end
end
