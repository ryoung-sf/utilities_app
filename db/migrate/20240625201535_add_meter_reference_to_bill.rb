class AddMeterReferenceToBill < ActiveRecord::Migration[7.1]
  def change
    add_reference :bills, :meter, null: false, foreign_key: true, type: :uuid
    remove_reference :bills, :billing_account, null: false, foreign_key: true
  end
end
