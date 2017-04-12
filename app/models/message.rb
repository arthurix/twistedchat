class Message < ApplicationRecord
  def translate
    dispatch.translate
  end

  def dispatch
    clazz ||= class_eval(self.dialect.to_s.capitalize)
    clazz.new(self.text)
  end
end
