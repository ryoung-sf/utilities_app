class RemoveExternalUidFromReadings < ActiveRecord::Migration[7.1]
  def change
    remove_column :readings, :external_uid
  end
end
