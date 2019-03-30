ActiveAdmin.register EventSession do
  menu :label => 'Event Session List', :parent => 'Events'

  filter :name
  filter :placeholder

  index do
    column :id
    column :event
    column :name
    column :user
    column :start_time
    default_actions
  end

  form do |f|
    f.inputs "Event Session" do
      f.input :event
      f.input :user, :as => :select, :collection => [ f.object.user ].compact(), :input_html => { :class => 'need-user-autocomplete' }      
      f.input :name
      f.input :description
      f.input :need_projector
      f.input :need_microphone
      f.input :need_whiteboard
      f.input :placeholder
      f.input :presentation_url
      f.input :video_url
      f.input :start_time, :as => :just_datetime_picker
      f.input :end_time, :as => :just_datetime_picker
    end

    f.actions
  end

  before_update do |event_session|
    event_session.is_admin_update = true
  end
end
