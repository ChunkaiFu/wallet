class ChangeKycForeignKeyConstraint < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :kycs, :users
    add_foreign_key :kycs, :users, on_delete: :cascade
  end
end
