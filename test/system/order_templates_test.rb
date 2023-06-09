require "application_system_test_case"

class OrderTemplatesTest < ApplicationSystemTestCase
  setup do
    @order_template = order_templates(:one)
  end

  test "visiting the index" do
    visit order_templates_url
    assert_selector "h1", text: "Order templates"
  end

  test "should create order template" do
    visit order_templates_url
    click_on "New order template"

    click_on "Create Order template"

    assert_text "Order template was successfully created"
    click_on "Back"
  end

  test "should update Order template" do
    visit order_template_url(@order_template)
    click_on "Edit this order template", match: :first

    click_on "Update Order template"

    assert_text "Order template was successfully updated"
    click_on "Back"
  end

  test "should destroy Order template" do
    visit order_template_url(@order_template)
    click_on "Destroy this order template", match: :first

    assert_text "Order template was successfully destroyed"
  end
end
