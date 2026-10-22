require "test_helper"

class MaintenanceReportsControllerTest < ActionDispatch::IntegrationTest
  test "index requires authentication" do
    get maintenance_report_path
    assert_redirected_to new_session_path
  end

  test "index renders when authenticated" do
    sign_in_as(User.take)
    get maintenance_report_path
    assert_response :success
  end

  test "filters by status" do
    sign_in_as(User.take)
    get maintenance_report_path, params: { status: "completed" }
    assert_response :success
  end

  test "exports CSV with the expected columns in order" do
    sign_in_as(User.take)
    get maintenance_report_path(format: :csv)
    assert_response :success
    assert_equal "text/csv", response.media_type
    assert_equal "Data de Abertura,Data Agendada,Veículo,Placa,km,Data de Saída,O que foi feito",
                 response.body.lines.first.strip
  end
end
