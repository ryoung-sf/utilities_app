class RemoveBillingAccountFromMeters < ActiveRecord::Migration[7.1]
  def change
    remove_reference :meters, :billing_account, null: false, foreign_key: true, type: :uuid
  end
end
