require 'test_helper'

class EventRegistrationsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "Access event registration page" do
    sign_in users(:two)

    registration = event_registrations(:one)
    event = events(:one)

    get event_event_registrations_path(event)
    assert_response :ok

    assert_raise (AbstractController::ActionNotFound) { get event_event_registration_path(event, registration) }  #* Invalid operation

    get new_event_event_registration_path(event)
    assert_response :ok

    assert_raise (AbstractController::ActionNotFound) { get edit_event_event_registration_path(event, registration) } #* Invalid operation
  end
  
  test "Unauthenticated user should be redirected" do
    event = events(:one)
    
    get new_event_event_registration_path(event)
    assert_redirected_to new_user_session_path
  end

  test "Successfull registration redirects to event page" do
    sign_in users(:two)
    event = events(:one)
    registration = event_registrations(:one)
    
    post event_event_registrations_path(event), event_registrations: registration 
    assert_redirected_to event_path(event) 
  end
end
