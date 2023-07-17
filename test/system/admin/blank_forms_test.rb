require "application_system_test_case"

class Admin::BlankFormsTest < ApplicationSystemTestCase
  setup do
    @admin_blank_form = admin_blank_forms(:one)
  end

  test "visiting the index" do
    visit admin_blank_forms_url
    assert_selector "h1", text: "Blank forms"
  end

  test "should create blank form" do
    visit admin_blank_forms_url
    click_on "New blank form"

    click_on "Create Blank form"

    assert_text "Blank form was successfully created"
    click_on "Back"
  end

  test "should update Blank form" do
    visit admin_blank_form_url(@admin_blank_form)
    click_on "Edit this blank form", match: :first

    click_on "Update Blank form"

    assert_text "Blank form was successfully updated"
    click_on "Back"
  end

  test "should destroy Blank form" do
    visit admin_blank_form_url(@admin_blank_form)
    click_on "Destroy this blank form", match: :first

    assert_text "Blank form was successfully destroyed"
  end
end
