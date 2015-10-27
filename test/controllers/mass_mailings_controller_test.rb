require 'test_helper'

class MassMailingsControllerTest < ActionController::TestCase
  setup do
    @mass_mailing = mass_mailings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mass_mailings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mass_mailing" do
    assert_difference('MassMailing.count') do
      post :create, mass_mailing: { finished: @mass_mailing.finished, started: @mass_mailing.started, title: @mass_mailing.title }
    end

    assert_redirected_to mass_mailing_path(assigns(:mass_mailing))
  end

  test "should show mass_mailing" do
    get :show, id: @mass_mailing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mass_mailing
    assert_response :success
  end

  test "should update mass_mailing" do
    patch :update, id: @mass_mailing, mass_mailing: { finished: @mass_mailing.finished, started: @mass_mailing.started, title: @mass_mailing.title }
    assert_redirected_to mass_mailing_path(assigns(:mass_mailing))
  end

  test "should destroy mass_mailing" do
    assert_difference('MassMailing.count', -1) do
      delete :destroy, id: @mass_mailing
    end

    assert_redirected_to mass_mailings_path
  end
end
