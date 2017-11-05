require 'test_helper'

class HwControllerTest < ActionDispatch::IntegrationTest
  test "should get id" do
    get hw_id_url
    assert_response :success
  end

end
