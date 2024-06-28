class ChangeIntegerToDecimal < ActiveRecord::Migration[7.1]
  def change
    remove_column :bills, :total_kwh_times_100
    add_column :bills, :total_kwh, :decimal, precision: 10, scale: 6, default: 0
    remove_column :bills, :total_volume_times_100
    add_column :bills, :total_volume, :decimal, precision: 10, scale: 6, default: 0

    remove_column :line_items, :rate_times_10000
    add_column :line_items, :rate, :decimal, precision: 10, scale: 6, default: 0
    remove_column :line_items, :volume_times_100
    add_column :line_items, :volume, :decimal, precision: 10, scale: 6, default: 0

    remove_column :readings, :value_times_1000
    add_column :readings, :value, :decimal, precision: 10, scale: 6, default: 0
  end
end
