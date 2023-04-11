class DropCardTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :cards
  end
end
