class CreateAuthorizations < ActiveRecord::Migration[7.1]
  def change
    create_table :authorizations, id: :uuid do |t|
      t.string :auth_id, null: false
      t.datetime :submitted_date, null: false
      t.string :customer_email, null: false
      t.jsonb :customer_signature
      t.datetime :declined_date
      t.datetime :expired_date
      t.jsonb :exports_list
      t.boolean :is_archived, null: false, default: false
      t.jsonb :notes
      t.string :nickname
      t.datetime :revoked_date
      t.jsonb :scope
      t.string :status
      t.string :status_message
      t.datetime :status_updated_date
      t.string :utility, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
