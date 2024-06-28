class RemoveNullFromBillingAddress < ActiveRecord::Migration[7.1]
  def change
    change_column_null(:billing_accounts, :utility_account_id, true)
  end
end
