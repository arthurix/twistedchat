class UserActivity < ApplicationRecord
  belongs_to :user

  scope :active, -> (username) do
    where(username: username, status: 'activate')
  end
  scope :online, -> { where(status: 'activate') }
end
