class CreateMeters < ActiveRecord::Migration[7.1]
  def change
    create_table :meters, id: :uuid do |t|
      t.string :external_uid, null: false
      t.string :service_class
      t.string :service_id, null: false
      t.string :service_tariff
      t.datetime :created_date, null: false
      t.string :utility_meter_id, null: false
      t.datetime :status_date, null: false
      t.string :status
      t.references :billing_account, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
