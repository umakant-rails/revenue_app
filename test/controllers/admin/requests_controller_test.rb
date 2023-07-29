require "test_helper"

class Admin::RequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_request = admin_requests(:one)
  end

  test "should get index" do
    get admin_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_request_url
    assert_response :success
  end

  test "should create admin_request" do
    assert_difference("Admin::Request.count") do
      post admin_requests_url, params: { admin_request: {  } }
    end

    assert_redirected_to admin_request_url(Admin::Request.last)
  end

  test "should show admin_request" do
    get admin_request_url(@admin_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_request_url(@admin_request)
    assert_response :success
  end

  test "should update admin_request" do
    patch admin_request_url(@admin_request), params: { admin_request: {  } }
    assert_redirected_to admin_request_url(@admin_request)
  end

  test "should destroy admin_request" do
    assert_difference("Admin::Request.count", -1) do
      delete admin_request_url(@admin_request)
    end

    assert_redirected_to admin_requests_url
  end
end
