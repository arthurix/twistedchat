class User
  attr_accessor :username, :dialect

  DIALECTS = %w(yoda valley binary).freeze
  USERNAME_REGEX = /\w+/

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  validates :username, presence: true,
            format: { with: /\A#{USERNAME_REGEX}\z/i },
            length: { maximum: 15 }
  validates :dialect, :presence => true
  validates_inclusion_of :dialect, in: DIALECTS, allow_nil: false
  validate :username_already_taken

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def username_already_taken
    unless UserActivity.active(self.username).blank?
      errors.add(:username, "#{self.username} has already been taken")
    end
  end
end
