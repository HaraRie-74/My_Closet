require "test_helper"

class ClosetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get closets_new_url
    assert_response :success
  end

  test "should get create" do
    get closets_create_url
    assert_response :success
  end

  test "should get index" do
    get closets_index_url
    assert_response :success
  end

  test "should get show" do
    get closets_show_url
    assert_response :success
  end

  test "should get edit" do
    get closets_edit_url
    assert_response :success
  end

  test "should get update" do
    get closets_update_url
    assert_response :success
  end

  test "should get destroy" do
    get closets_destroy_url
    assert_response :success
  end
end
