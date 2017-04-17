class CreateUserActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :user_activities do |t|
      t.string :username, :primary => true
      t.string :dialect
      t.string :status
    end
  end
end
