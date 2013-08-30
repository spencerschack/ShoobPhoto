require 'test_helper'

class CatalogControllerTest < ActionController::TestCase
  test "should get schools" do
    get :schools
    assert_response :success
  end

  test "should get package_types" do
    get :package_types
    assert_response :success
  end

  test "should get packages" do
    get :packages
    assert_response :success
  end

  test "should get package" do
    get :package
    assert_response :success
  end

end
