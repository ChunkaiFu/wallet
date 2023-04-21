class AddSecEmailToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :sender_email, :string
  end
end
