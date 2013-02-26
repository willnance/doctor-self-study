require 'test_helper'

class AccessControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get attempt_login" do
    get :attempt_login
    assert_response :success
  end

  test "should get menu" do
    get :menu
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

end
