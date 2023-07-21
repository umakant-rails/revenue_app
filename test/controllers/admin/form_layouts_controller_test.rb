require "test_helper"

class Admin::FormLayoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_form_layout = admin_form_layouts(:one)
  end

  test "should get index" do
    get admin_form_layouts_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_form_layout_url
    assert_response :success
  end

  test "should create admin_form_layout" do
    assert_difference("Admin::FormLayout.count") do
      post admin_form_layouts_url, params: { admin_form_layout: {  } }
    end

    assert_redirected_to admin_form_layout_url(Admin::FormLayout.last)
  end

  test "should show admin_form_layout" do
    get admin_form_layout_url(@admin_form_layout)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_form_layout_url(@admin_form_layout)
    assert_response :success
  end

  test "should update admin_form_layout" do
    patch admin_form_layout_url(@admin_form_layout), params: { admin_form_layout: {  } }
    assert_redirected_to admin_form_layout_url(@admin_form_layout)
  end

  test "should destroy admin_form_layout" do
    assert_difference("Admin::FormLayout.count", -1) do
      delete admin_form_layout_url(@admin_form_layout)
    end

    assert_redirected_to admin_form_layouts_url
  end
end
