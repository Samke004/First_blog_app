require "test_helper"

class Admin::AppSettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_app_settings_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_app_settings_update_url
    assert_response :success
  end
end
