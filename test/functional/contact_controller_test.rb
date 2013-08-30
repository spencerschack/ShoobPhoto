require 'test_helper'

class ContactControllerTest < ActionController::TestCase
  test "should get message" do
    get :message
    assert_response :success
  end

  test "should get job_application" do
    get :job_application
    assert_response :success
  end

end
