require "test_helper"

class BlankFormsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blank_form = blank_forms(:one)
  end

  test "should get index" do
    get blank_forms_url
    assert_response :success
  end

  test "should get new" do
    get new_blank_form_url
    assert_response :success
  end

  test "should create blank_form" do
    assert_difference("BlankForm.count") do
      post blank_forms_url, params: { blank_form: { category: @blank_form.category, content: @blank_form.content, department: @blank_form.department, name: @blank_form.name } }
    end

    assert_redirected_to blank_form_url(BlankForm.last)
  end

  test "should show blank_form" do
    get blank_form_url(@blank_form)
    assert_response :success
  end

  test "should get edit" do
    get edit_blank_form_url(@blank_form)
    assert_response :success
  end

  test "should update blank_form" do
    patch blank_form_url(@blank_form), params: { blank_form: { category: @blank_form.category, content: @blank_form.content, department: @blank_form.department, name: @blank_form.name } }
    assert_redirected_to blank_form_url(@blank_form)
  end

  test "should destroy blank_form" do
    assert_difference("BlankForm.count", -1) do
      delete blank_form_url(@blank_form)
    end

    assert_redirected_to blank_forms_url
  end
end
