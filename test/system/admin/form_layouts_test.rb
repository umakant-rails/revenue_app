require "application_system_test_case"

class Admin::FormLayoutsTest < ApplicationSystemTestCase
  setup do
    @admin_form_layout = admin_form_layouts(:one)
  end

  test "visiting the index" do
    visit admin_form_layouts_url
    assert_selector "h1", text: "Form layouts"
  end

  test "should create form layout" do
    visit admin_form_layouts_url
    click_on "New form layout"

    click_on "Create Form layout"

    assert_text "Form layout was successfully created"
    click_on "Back"
  end

  test "should update Form layout" do
    visit admin_form_layout_url(@admin_form_layout)
    click_on "Edit this form layout", match: :first

    click_on "Update Form layout"

    assert_text "Form layout was successfully updated"
    click_on "Back"
  end

  test "should destroy Form layout" do
    visit admin_form_layout_url(@admin_form_layout)
    click_on "Destroy this form layout", match: :first

    assert_text "Form layout was successfully destroyed"
  end
end
