require "test_helper"

class OrderTemplatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_template = order_templates(:one)
  end

  test "should get index" do
    get order_templates_url
    assert_response :success
  end

  test "should get new" do
    get new_order_template_url
    assert_response :success
  end

  test "should create order_template" do
    assert_difference("OrderTemplate.count") do
      post order_templates_url, params: { order_template: {  } }
    end

    assert_redirected_to order_template_url(OrderTemplate.last)
  end

  test "should show order_template" do
    get order_template_url(@order_template)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_template_url(@order_template)
    assert_response :success
  end

  test "should update order_template" do
    patch order_template_url(@order_template), params: { order_template: {  } }
    assert_redirected_to order_template_url(@order_template)
  end

  test "should destroy order_template" do
    assert_difference("OrderTemplate.count", -1) do
      delete order_template_url(@order_template)
    end

    assert_redirected_to order_templates_url
  end
end
