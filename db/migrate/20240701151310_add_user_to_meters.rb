class AddUserToMeters < ActiveRecord::Migration[7.1]
  def change
    add_reference :meters, :user, null: false, foreign_key: true, type: :uuid
    add_reference :meters, :authorization, null: false, foreign_key: true, type: :uuid
  end
end
