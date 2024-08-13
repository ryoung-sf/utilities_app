class AddStatusMessageToMeters < ActiveRecord::Migration[7.1]
  def change
    add_column :meters, :status_message, :string
    add_column :meters, :notes, :jsonb
  end
end
