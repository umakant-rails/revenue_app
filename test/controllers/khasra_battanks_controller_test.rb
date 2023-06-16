require "test_helper"

class KhasraBattanksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @khasra_battank = khasra_battanks(:one)
  end

  test "should get index" do
    get khasra_battanks_url
    assert_response :success
  end

  test "should get new" do
    get new_khasra_battank_url
    assert_response :success
  end

  test "should create khasra_battank" do
    assert_difference("KhasraBattank.count") do
      post khasra_battanks_url, params: { khasra_battank: {  } }
    end

    assert_redirected_to khasra_battank_url(KhasraBattank.last)
  end

  test "should show khasra_battank" do
    get khasra_battank_url(@khasra_battank)
    assert_response :success
  end

  test "should get edit" do
    get edit_khasra_battank_url(@khasra_battank)
    assert_response :success
  end

  test "should update khasra_battank" do
    patch khasra_battank_url(@khasra_battank), params: { khasra_battank: {  } }
    assert_redirected_to khasra_battank_url(@khasra_battank)
  end

  test "should destroy khasra_battank" do
    assert_difference("KhasraBattank.count", -1) do
      delete khasra_battank_url(@khasra_battank)
    end

    assert_redirected_to khasra_battanks_url
  end
end
