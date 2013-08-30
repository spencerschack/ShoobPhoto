require 'test_helper'

class ProofsControllerTest < ActionController::TestCase
  setup do
    @proof = proofs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proofs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proof" do
    assert_difference('Proof.count') do
      post :create, :proof => @proof.attributes
    end

    assert_redirected_to proof_path(assigns(:proof))
  end

  test "should show proof" do
    get :show, :id => @proof.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @proof.to_param
    assert_response :success
  end

  test "should update proof" do
    put :update, :id => @proof.to_param, :proof => @proof.attributes
    assert_redirected_to proof_path(assigns(:proof))
  end

  test "should destroy proof" do
    assert_difference('Proof.count', -1) do
      delete :destroy, :id => @proof.to_param
    end

    assert_redirected_to proofs_path
  end
end
