require 'test_helper'

class ImageSetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get image_sets_index_url
    assert_response :success
  end

  test "should get show" do
    get image_sets_show_url
    assert_response :success
  end

end
