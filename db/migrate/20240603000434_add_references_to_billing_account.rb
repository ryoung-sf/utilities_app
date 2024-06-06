class AddReferencesToBillingAccount < ActiveRecord::Migration[7.1]
  def change
    add_reference :billing_accounts, :meter, null: false, foreign_key: true, type: :uuid
    add_reference :billing_accounts, :bill, null: false, foreign_key: true, type: :uuid
    remove_reference :billing_accounts, :authorization, null: false, foreign_key: true, type: :uuid
  end
end
