class RemoveBillingAccountReferenceFromBills < ActiveRecord::Migration[7.1]
  def change
    remove_reference :bills, :billing_account, null: false, foreign_key: true, type: :uuid
  end
end
