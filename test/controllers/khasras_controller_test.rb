require "test_helper"

class KhasrasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @khasra = khasras(:one)
  end

  test "should get index" do
    get khasras_url
    assert_response :success
  end

  test "should get new" do
    get new_khasra_url
    assert_response :success
  end

  test "should create khasra" do
    assert_difference("Khasra.count") do
      post khasras_url, params: { khasra: {  } }
    end

    assert_redirected_to khasra_url(Khasra.last)
  end

  test "should show khasra" do
    get khasra_url(@khasra)
    assert_response :success
  end

  test "should get edit" do
    get edit_khasra_url(@khasra)
    assert_response :success
  end

  test "should update khasra" do
    patch khasra_url(@khasra), params: { khasra: {  } }
    assert_redirected_to khasra_url(@khasra)
  end

  test "should destroy khasra" do
    assert_difference("Khasra.count", -1) do
      delete khasra_url(@khasra)
    end

    assert_redirected_to khasras_url
  end
end
