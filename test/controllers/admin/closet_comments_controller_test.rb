require "test_helper"

class Admin::ClosetCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admin_closet_comments_destroy_url
    assert_response :success
  end
end
