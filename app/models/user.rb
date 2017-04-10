class User
  attr_accessor :username

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  validates :username, :presence => true
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end
