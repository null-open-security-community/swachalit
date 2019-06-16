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
    assert_response :redirect #TODO: check for redirect location.
  end

  test "Successfull registration redirects to event page" do
    event = events(:one)
    registration = event_registrations(:one)
    
    post event_event_registrations_path(event), event_registrations: registration 
    assert_response :redirect #TODO: check for redirect location. 
  end
end
