class CreateKycs < ActiveRecord::Migration[7.0]
  def change
    create_table :kycs do |t|
      t.string :license_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
