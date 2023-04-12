require 'rails_helper'

RSpec.describe "wallets/edit", type: :view do
  let(:wallet) {
    Wallet.create!(
      user: nil
    )
  }

  before(:each) do
    assign(:wallet, wallet)
  end

  it "renders the edit wallet form" do
    render

    assert_select "form[action=?][method=?]", wallet_path(wallet), "post" do

      assert_select "input[name=?]", "wallet[user_id]"
    end
  end
end
