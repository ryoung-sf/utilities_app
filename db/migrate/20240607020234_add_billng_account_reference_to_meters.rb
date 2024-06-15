class AddBillngAccountReferenceToMeters < ActiveRecord::Migration[7.1]
  def change
    add_reference :meters, :billing_account, null: false, foreign_key: true, type: :uuid
    
    remove_reference :meters, :authorization, null: false, foreign_key: true, type: :uuid
  end
end
