require 'test_helper'

class CartControllerTest < ActionController::TestCase
  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get checkout" do
    get :checkout
    assert_response :success
  end

  test "should get receipt" do
    get :receipt
    assert_response :success
  end

end
