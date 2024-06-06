class CreateLineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :line_items, id: :uuid do |t|
      t.integer :cost_cents, null: false
      t.datetime :end_date, null: false
      t.datetime :start_date, null: false
      t.string :name, null: false
      t.integer :rate_times_10000
      t.string :unit
      t.integer :volume_times_100
      t.references :bill, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
