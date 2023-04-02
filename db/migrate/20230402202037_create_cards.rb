class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :issuer
      t.string :card_number
      t.string :expiration_date
      t.string :card_holder_name
      t.string :cvv
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
