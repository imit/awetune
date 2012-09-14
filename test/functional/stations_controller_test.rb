require 'test_helper'

class StationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Station.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Station.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Station.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to station_url(assigns(:station))
  end

  def test_edit
    get :edit, :id => Station.first
    assert_template 'edit'
  end

  def test_update_invalid
    Station.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Station.first
    assert_template 'edit'
  end

  def test_update_valid
    Station.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Station.first
    assert_redirected_to station_url(assigns(:station))
  end

  def test_destroy
    station = Station.first
    delete :destroy, :id => station
    assert_redirected_to stations_url
    assert !Station.exists?(station.id)
  end
end
