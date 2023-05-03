class AddStatusToKycs < ActiveRecord::Migration[7.0]
  def change
    add_column :kycs, :status, :string
  end
end
