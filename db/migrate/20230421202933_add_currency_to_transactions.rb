class AddCurrencyToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :currency, :string
  end
end
