class RenameIntervalToReading < ActiveRecord::Migration[7.1]
  def change
    rename_table :intervals, :readings
  end
end
