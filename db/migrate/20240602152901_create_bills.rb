class CreateBills < ActiveRecord::Migration[7.1]
  def change
    create_table :bills, id: :uuid do |t|
      t.string :external_uid, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.integer :total_kwh_times_100
      t.string :total_unit
      t.integer :total_volume_times_100
      t.integer :total_cost_cents
      t.references :billing_account, null: false, foreign_key: true, type: :uuid
      t.string :raw_url

      t.timestamps
    end
  end
end
