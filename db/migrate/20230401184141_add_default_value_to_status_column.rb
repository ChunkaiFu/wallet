class AddDefaultValueToStatusColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :kycs, :status, :string, from: nil, to: 'pending'
  end
end
