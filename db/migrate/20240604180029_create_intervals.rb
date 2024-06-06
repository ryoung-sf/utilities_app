class CreateIntervals < ActiveRecord::Migration[7.1]
  def change
    create_table :intervals, id: :uuid do |t|
      t.string :external_uid, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :unit, null: false
      t.integer :value_times_1000, null: false, default: 0
      t.string :volume_type, null: false
      t.references :meter, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
