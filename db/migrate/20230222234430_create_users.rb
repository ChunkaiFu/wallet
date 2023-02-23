class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :Username
      t.string :Firstname
      t.string :Lastname
      t.string :email
      t.boolean :KYC_Approved
      t.string :Password

      t.timestamps
    end
  end
end
