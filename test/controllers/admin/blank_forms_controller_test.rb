require "test_helper"

class Admin::BlankFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_blank_form = admin_blank_forms(:one)
  end

  test "should get index" do
    get admin_blank_forms_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_blank_form_url
    assert_response :success
  end

  test "should create admin_blank_form" do
    assert_difference("Admin::BlankForm.count") do
      post admin_blank_forms_url, params: { admin_blank_form: {  } }
    end

    assert_redirected_to admin_blank_form_url(Admin::BlankForm.last)
  end

  test "should show admin_blank_form" do
    get admin_blank_form_url(@admin_blank_form)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_blank_form_url(@admin_blank_form)
    assert_response :success
  end

  test "should update admin_blank_form" do
    patch admin_blank_form_url(@admin_blank_form), params: { admin_blank_form: {  } }
    assert_redirected_to admin_blank_form_url(@admin_blank_form)
  end

  test "should destroy admin_blank_form" do
    assert_difference("Admin::BlankForm.count", -1) do
      delete admin_blank_form_url(@admin_blank_form)
    end

    assert_redirected_to admin_blank_forms_url
  end
end
