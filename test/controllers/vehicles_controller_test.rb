require "test_helper"

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  test "index requires authentication" do
    get vehicles_path
    assert_redirected_to new_session_path
  end

  test "index renders when authenticated" do
    sign_in_as(User.take)
    get vehicles_path
    assert_response :success
  end
end
