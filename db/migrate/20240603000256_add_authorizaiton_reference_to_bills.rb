class AddAuthorizaitonReferenceToBills < ActiveRecord::Migration[7.1]
  def change
    add_reference :bills, :authorization, null: false, foreign_key: true, type: :uuid
  end
end
