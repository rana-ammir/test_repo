require 'test_helper'

class UserboardsControllerTest < ActionController::TestCase
  setup do
    @userboard = userboards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:userboards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create userboard" do
    assert_difference('Userboard.count') do
      post :create, userboard: {  }
    end

    assert_redirected_to userboard_path(assigns(:userboard))
  end

  test "should show userboard" do
    get :show, id: @userboard
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @userboard
    assert_response :success
  end

  test "should update userboard" do
    patch :update, id: @userboard, userboard: {  }
    assert_redirected_to userboard_path(assigns(:userboard))
  end

  test "should destroy userboard" do
    assert_difference('Userboard.count', -1) do
      delete :destroy, id: @userboard
    end

    assert_redirected_to userboards_path
  end
end
