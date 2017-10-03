require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get nao_autorizado" do
    get :nao_autorizado
    assert_response :success
  end

end
