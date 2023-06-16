require "application_system_test_case"

class KhasraBattanksTest < ApplicationSystemTestCase
  setup do
    @khasra_battank = khasra_battanks(:one)
  end

  test "visiting the index" do
    visit khasra_battanks_url
    assert_selector "h1", text: "Khasra battanks"
  end

  test "should create khasra battank" do
    visit khasra_battanks_url
    click_on "New khasra battank"

    click_on "Create Khasra battank"

    assert_text "Khasra battank was successfully created"
    click_on "Back"
  end

  test "should update Khasra battank" do
    visit khasra_battank_url(@khasra_battank)
    click_on "Edit this khasra battank", match: :first

    click_on "Update Khasra battank"

    assert_text "Khasra battank was successfully updated"
    click_on "Back"
  end

  test "should destroy Khasra battank" do
    visit khasra_battank_url(@khasra_battank)
    click_on "Destroy this khasra battank", match: :first

    assert_text "Khasra battank was successfully destroyed"
  end
end
