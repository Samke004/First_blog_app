require "test_helper"

class Admin::AdministratorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_administrators_index_url
    assert_response :success
  end
end
