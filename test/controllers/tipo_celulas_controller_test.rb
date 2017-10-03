require 'test_helper'

class TipoCelulasControllerTest < ActionController::TestCase
  setup do
    @tipo_celula = tipo_celulas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_celulas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tipo_celula" do
    assert_difference('TipoCelula.count') do
      post :create, tipo_celula: {  }
    end

    assert_redirected_to tipo_celula_path(assigns(:tipo_celula))
  end

  test "should show tipo_celula" do
    get :show, id: @tipo_celula
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tipo_celula
    assert_response :success
  end

  test "should update tipo_celula" do
    patch :update, id: @tipo_celula, tipo_celula: {  }
    assert_redirected_to tipo_celula_path(assigns(:tipo_celula))
  end

  test "should destroy tipo_celula" do
    assert_difference('TipoCelula.count', -1) do
      delete :destroy, id: @tipo_celula
    end

    assert_redirected_to tipo_celulas_path
  end
end
