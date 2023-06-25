require "application_system_test_case"

class BlankFormsTest < ApplicationSystemTestCase
  setup do
    @blank_form = blank_forms(:one)
  end

  test "visiting the index" do
    visit blank_forms_url
    assert_selector "h1", text: "Blank forms"
  end

  test "should create blank form" do
    visit blank_forms_url
    click_on "New blank form"

    fill_in "Category", with: @blank_form.category
    fill_in "Content", with: @blank_form.content
    fill_in "Department", with: @blank_form.department
    fill_in "Name", with: @blank_form.name
    click_on "Create Blank form"

    assert_text "Blank form was successfully created"
    click_on "Back"
  end

  test "should update Blank form" do
    visit blank_form_url(@blank_form)
    click_on "Edit this blank form", match: :first

    fill_in "Category", with: @blank_form.category
    fill_in "Content", with: @blank_form.content
    fill_in "Department", with: @blank_form.department
    fill_in "Name", with: @blank_form.name
    click_on "Update Blank form"

    assert_text "Blank form was successfully updated"
    click_on "Back"
  end

  test "should destroy Blank form" do
    visit blank_form_url(@blank_form)
    click_on "Destroy this blank form", match: :first

    assert_text "Blank form was successfully destroyed"
  end
end
