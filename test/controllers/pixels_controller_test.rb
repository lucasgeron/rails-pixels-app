require "test_helper"

class PixelsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pixels_index_url
    assert_response :success
  end
end
