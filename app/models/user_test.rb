require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(Username: "Example User", email: "user@example.com")
  end
  
  
  
  test "name should not be too long" do
    @user.Username = "Sambhav"
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
end