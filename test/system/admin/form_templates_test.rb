require "application_system_test_case"

class Admin::FormTemplatesTest < ApplicationSystemTestCase
  setup do
    @admin_form_template = admin_form_templates(:one)
  end

  test "visiting the index" do
    visit admin_form_templates_url
    assert_selector "h1", text: "Form templates"
  end

  test "should create form template" do
    visit admin_form_templates_url
    click_on "New form template"

    click_on "Create Form template"

    assert_text "Form template was successfully created"
    click_on "Back"
  end

  test "should update Form template" do
    visit admin_form_template_url(@admin_form_template)
    click_on "Edit this form template", match: :first

    click_on "Update Form template"

    assert_text "Form template was successfully updated"
    click_on "Back"
  end

  test "should destroy Form template" do
    visit admin_form_template_url(@admin_form_template)
    click_on "Destroy this form template", match: :first

    assert_text "Form template was successfully destroyed"
  end
end
