require 'test_helper'

class ImitModsControllerTest < ActionController::TestCase
  setup do
    @imit_mod = imit_mods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:imit_mods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create imit_mod" do
    assert_difference('ImitMod.count') do
      post :create, imit_mod: {  }
    end

    assert_redirected_to imit_mod_path(assigns(:imit_mod))
  end

  test "should show imit_mod" do
    get :show, id: @imit_mod
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @imit_mod
    assert_response :success
  end

  test "should update imit_mod" do
    patch :update, id: @imit_mod, imit_mod: {  }
    assert_redirected_to imit_mod_path(assigns(:imit_mod))
  end

  test "should destroy imit_mod" do
    assert_difference('ImitMod.count', -1) do
      delete :destroy, id: @imit_mod
    end

    assert_redirected_to imit_mods_path
  end
end
