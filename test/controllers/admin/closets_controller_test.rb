require "test_helper"

class Admin::ClosetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_closets_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_closets_show_url
    assert_response :success
  end
end
