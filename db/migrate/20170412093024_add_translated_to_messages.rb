class AddTranslatedToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :translated, :string
  end
end
