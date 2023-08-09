require "test_helper"

class Public::ChatRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_chat_rooms_show_url
    assert_response :success
  end

  test "should get create" do
    get public_chat_rooms_create_url
    assert_response :success
  end

  test "should get index" do
    get public_chat_rooms_index_url
    assert_response :success
  end
end
