require "test_helper"

class MaintenanceOrdersControllerTest < ActionDispatch::IntegrationTest
  test "index requires authentication" do
    get maintenance_orders_path
    assert_redirected_to new_session_path
  end

  test "index renders when authenticated" do
    sign_in_as(User.take)
    get maintenance_orders_path
    assert_response :success
  end
end
