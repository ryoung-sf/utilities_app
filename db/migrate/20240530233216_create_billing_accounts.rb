class CreateBillingAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :billing_accounts, id: :uuid do |t|
      t.string :utility_account_id, null: false
      t.string :contact_name
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :authorization, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
