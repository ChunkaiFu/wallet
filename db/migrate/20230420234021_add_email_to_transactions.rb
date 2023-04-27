class AddEmailToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :receiver_email, :string
  end
end
