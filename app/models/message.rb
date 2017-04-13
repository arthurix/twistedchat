class Message < ApplicationRecord
  def translate
    dispatch.translate
  end

  def dispatch
    clazz ||= class_eval(dialect.to_s.capitalize)
    clazz.new(text, dialect)
  end
end
