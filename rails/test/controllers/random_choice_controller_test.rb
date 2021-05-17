require "test_helper"

class RandomChoiceControllerTest < ActionDispatch::IntegrationTest
  test "should get terms" do
    get random_choice_terms_url
    assert_response :success
  end
end
