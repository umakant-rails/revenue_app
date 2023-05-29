require "application_system_test_case"

class KhasrasTest < ApplicationSystemTestCase
  setup do
    @khasra = khasras(:one)
  end

  test "visiting the index" do
    visit khasras_url
    assert_selector "h1", text: "Khasras"
  end

  test "should create khasra" do
    visit khasras_url
    click_on "New khasra"

    click_on "Create Khasra"

    assert_text "Khasra was successfully created"
    click_on "Back"
  end

  test "should update Khasra" do
    visit khasra_url(@khasra)
    click_on "Edit this khasra", match: :first

    click_on "Update Khasra"

    assert_text "Khasra was successfully updated"
    click_on "Back"
  end

  test "should destroy Khasra" do
    visit khasra_url(@khasra)
    click_on "Destroy this khasra", match: :first

    assert_text "Khasra was successfully destroyed"
  end
end
