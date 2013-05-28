require 'test_helper'

class EmployeeApplicationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:instructor_applications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create instructor_application" do
    assert_difference('InstructorApplication.count') do
      post :create, :instructor_application => { }
    end

    assert_redirected_to instructor_application_path(assigns(:instructor_application))
  end

  test "should show instructor_application" do
    get :show, :id => instructor_applications(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => instructor_applications(:one).to_param
    assert_response :success
  end

  test "should update instructor_application" do
    put :update, :id => instructor_applications(:one).to_param, :instructor_application => { }
    assert_redirected_to instructor_application_path(assigns(:instructor_application))
  end

  test "should destroy instructor_application" do
    assert_difference('InstructorApplication.count', -1) do
      delete :destroy, :id => instructor_applications(:one).to_param
    end

    assert_redirected_to instructor_applications_path
  end
end
