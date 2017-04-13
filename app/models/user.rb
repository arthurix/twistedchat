class User
  attr_accessor :username, :dialect

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  validates :username, :presence => true
  validates :dialect, :presence => true
  validates_inclusion_of :dialect, :in => %w(yoda valley binary), :allow_nil => false

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end
