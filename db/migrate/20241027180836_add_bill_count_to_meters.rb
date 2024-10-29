class AddBillCountToMeters < ActiveRecord::Migration[7.1]
  def change
    add_column :meters, :bill_count, :integer, default: 0, null: false
  end
end
