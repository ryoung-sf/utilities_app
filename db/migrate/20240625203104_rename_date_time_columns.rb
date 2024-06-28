class RenameDateTimeColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :authorizations, :submitted_date, :submitted_at
    rename_column :authorizations, :declined_date, :declined_at
    rename_column :authorizations, :expired_date, :expired_at
    rename_column :authorizations, :revoked_date, :revoked_at
    rename_column :authorizations, :status_updated_date, :status_updated_at
    rename_column :bills, :start_date, :start_at
    rename_column :bills, :end_date, :end_at
    rename_column :bills, :statement_date, :statement_at
    rename_column :line_items, :end_date, :end_at
    rename_column :line_items, :start_date, :start_at
    rename_column :meters, :created_date, :activated_at
    rename_column :meters, :status_date, :status_at
    rename_column :readings, :start_date, :start_at
    rename_column :readings, :end_date, :end_at
  end
end
