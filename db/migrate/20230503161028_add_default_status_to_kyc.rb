class AddDefaultStatusToKyc < ActiveRecord::Migration[7.0]
  def change
    change_column :kycs, :status, :string, default: "pending"
  end
end
