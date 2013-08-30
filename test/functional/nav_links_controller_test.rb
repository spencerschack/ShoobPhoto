require 'test_helper'

class NavLinksControllerTest < ActionController::TestCase
  setup do
    @nav_link = nav_links(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nav_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nav_link" do
    assert_difference('NavLink.count') do
      post :create, :nav_link => @nav_link.attributes
    end

    assert_redirected_to nav_link_path(assigns(:nav_link))
  end

  test "should show nav_link" do
    get :show, :id => @nav_link.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @nav_link.to_param
    assert_response :success
  end

  test "should update nav_link" do
    put :update, :id => @nav_link.to_param, :nav_link => @nav_link.attributes
    assert_redirected_to nav_link_path(assigns(:nav_link))
  end

  test "should destroy nav_link" do
    assert_difference('NavLink.count', -1) do
      delete :destroy, :id => @nav_link.to_param
    end

    assert_redirected_to nav_links_path
  end
end
