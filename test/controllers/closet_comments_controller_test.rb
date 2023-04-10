require "test_helper"

class ClosetCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get closet_comments_new_url
    assert_response :success
  end

  test "should get create" do
    get closet_comments_create_url
    assert_response :success
  end

  test "should get index" do
    get closet_comments_index_url
    assert_response :success
  end

  test "should get show" do
    get closet_comments_show_url
    assert_response :success
  end

  test "should get destroy" do
    get closet_comments_destroy_url
    assert_response :success
  end
end
