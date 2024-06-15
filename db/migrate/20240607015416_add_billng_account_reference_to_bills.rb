class AddBillngAccountReferenceToBills < ActiveRecord::Migration[7.1]
  def change
    add_reference :bills, :billing_account, null: false, foreign_key: true, type: :uuid
    
    remove_reference :bills, :authorization, null: false, foreign_key: true, type: :uuid
  end
end
