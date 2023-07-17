require "application_system_test_case"

class Admin::RequestsTest < ApplicationSystemTestCase
  setup do
    @admin_request = admin_requests(:one)
  end

  test "visiting the index" do
    visit admin_requests_url
    assert_selector "h1", text: "Requests"
  end

  test "should create request" do
    visit admin_requests_url
    click_on "New request"

    click_on "Create Request"

    assert_text "Request was successfully created"
    click_on "Back"
  end

  test "should update Request" do
    visit admin_request_url(@admin_request)
    click_on "Edit this request", match: :first

    click_on "Update Request"

    assert_text "Request was successfully updated"
    click_on "Back"
  end

  test "should destroy Request" do
    visit admin_request_url(@admin_request)
    click_on "Destroy this request", match: :first

    assert_text "Request was successfully destroyed"
  end
end
