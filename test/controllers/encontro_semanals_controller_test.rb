require 'test_helper'

class EncontroSemanalsControllerTest < ActionController::TestCase
  setup do
    @encontro_semanal = encontro_semanals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:encontro_semanals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create encontro_semanal" do
    assert_difference('EncontroSemanal.count') do
      post :create, encontro_semanal: {  }
    end

    assert_redirected_to encontro_semanal_path(assigns(:encontro_semanal))
  end

  test "should show encontro_semanal" do
    get :show, id: @encontro_semanal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @encontro_semanal
    assert_response :success
  end

  test "should update encontro_semanal" do
    patch :update, id: @encontro_semanal, encontro_semanal: {  }
    assert_redirected_to encontro_semanal_path(assigns(:encontro_semanal))
  end

  test "should destroy encontro_semanal" do
    assert_difference('EncontroSemanal.count', -1) do
      delete :destroy, id: @encontro_semanal
    end

    assert_redirected_to encontro_semanals_path
  end
end
