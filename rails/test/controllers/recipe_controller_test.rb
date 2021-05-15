require "test_helper"

class RecipeControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get recipe_list_url
    assert_response :success
  end
end
