require "test_helper"

class MaterialControllerTest < ActionDispatch::IntegrationTest
  test "should get detail" do
    get material_detail_url
    assert_response :success
  end
end
