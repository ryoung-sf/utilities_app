class AddStatementDateToBills < ActiveRecord::Migration[7.1]
  def change
    add_column :bills, :statement_date, :datetime
  end
end
