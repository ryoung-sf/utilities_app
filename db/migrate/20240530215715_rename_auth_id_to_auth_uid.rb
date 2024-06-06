class RenameAuthIdToAuthUid < ActiveRecord::Migration[7.1]
  def change
    rename_column :authorizations, :auth_id, :external_uid
  end
end
