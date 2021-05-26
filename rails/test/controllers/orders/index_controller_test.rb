require "test_helper"

class Orders::IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orders_index_index_url
    assert_response :success
  end
end
