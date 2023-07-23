require "test_helper"

class Admin::FormTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_form_template = admin_form_templates(:one)
  end

  test "should get index" do
    get admin_form_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_form_template_url
    assert_response :success
  end

  test "should create admin_form_template" do
    assert_difference("Admin::FormTemplate.count") do
      post admin_form_templates_url, params: { admin_form_template: {  } }
    end

    assert_redirected_to admin_form_template_url(Admin::FormTemplate.last)
  end

  test "should show admin_form_template" do
    get admin_form_template_url(@admin_form_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_form_template_url(@admin_form_template)
    assert_response :success
  end

  test "should update admin_form_template" do
    patch admin_form_template_url(@admin_form_template), params: { admin_form_template: {  } }
    assert_redirected_to admin_form_template_url(@admin_form_template)
  end

  test "should destroy admin_form_template" do
    assert_difference("Admin::FormTemplate.count", -1) do
      delete admin_form_template_url(@admin_form_template)
    end

    assert_redirected_to admin_form_templates_url
  end
end
