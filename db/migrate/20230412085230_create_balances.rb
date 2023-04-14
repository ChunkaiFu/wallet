class CreateBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :balances do |t|
      t.float :value
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
