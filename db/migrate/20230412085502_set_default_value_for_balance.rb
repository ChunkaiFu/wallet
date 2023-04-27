class SetDefaultValueForBalance < ActiveRecord::Migration[7.0]
  def change
    change_column :balances, :value, :float, precision: 10, scale: 2, default: 0.0
  end
end
