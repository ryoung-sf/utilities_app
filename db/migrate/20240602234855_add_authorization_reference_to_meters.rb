class AddAuthorizationReferenceToMeters < ActiveRecord::Migration[7.1]
  def change
    add_reference :meters, :authorization, null: false, foreign_key: true, type: :uuid
    remove_reference :meters, :billing_account, index: true, foreign_key: true
  end
end
