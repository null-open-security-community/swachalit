ActiveAdmin.register Event do
  menu :label => 'Event List', :parent => 'Events'

  action_item :view, :only => [:show] do
    link_to "View Event", event_path(event), :target => '_blank'
  end

  filter :chapter
  filter :venue
  filter :name
  filter :public
  filter :event_type
  filter :start_time
  filter :end_time

  index do
    column :id
    column :chapter
    column :event_type
    column :name
    column :public
    column :start_time

    actions
  end

  form do |f|
    f.inputs "Event Management" do
      %Q|
      <p style='padding: 1em;'>
        <strong>NOTE: </strong> Setting the <strong>public</strong> flag will publish the event. Although this is revertable however
        it is recommended to ensure that the <strong>Event</strong> and associated <strong>EventSessions</strong>
        are setup correctly. This is because notifications including speaker notification and various other
        scheduled tasks are fired when an Event is published.
        Some of the scheduled tasks include: <br/>
        <br/>
        * Announcement <br/>
        * Speaker Notification <br/>
        * Calendar Update <br/>
        * e.t.c <br/>
        <br/>
        <strong>Re-scheduling Event Tasks</strong>: If you have made any significant change in the event such
        as changing the data/time e.t.c and you want to refresh the scheduled tasks, you must unpublish and
        re-publish the event by changing the public flag accordingly. However do note that tasks that are already
        executed will not be re-scheduled.
      </p>
      |.html_safe
    end

    f.inputs "Basic Details" do
      f.input :event_type
      f.input :chapter
      f.input :venue
      f.input :name
      f.input :description, :hint => "This will be appended to auto generated event description. You can use Markdown/HTML here."
      f.input :can_show_on_homepage
      f.input :can_show_on_archive
      f.input :accepting_registration
      f.input :start_time, :as => :just_datetime_picker
      f.input :end_time, :as => :just_datetime_picker
    end

    f.inputs "Publishing" do
      f.input :public, :hint => "Setting this flag will publish the event and trigger associated scheduled tasks."
    end

    f.inputs "Registration" do
      f.input :registration_start_time, :as => :just_datetime_picker
      f.input :registration_end_time, :as => :just_datetime_picker
      f.input :registration_instructions, :hint => 'This will appear as instruction to users who attempt to register for this event. You can use Markdown HTML here.'
    end

    f.inputs "Media" do
      f.file_field :image, hint: 'Image will be rendered as part of page open graph image'
    end

    f.inputs "Notifications" do
      f.input :notification_state, :hint => 'To reset state, set this to "Init" (without quotes)'
      f.input :ready_for_announcement
      #f.input :announced_at, :as => :string, :hint => 'Keep this blank for delivery/re-delivery of notifications'
      f.input :ready_for_notifications
      #f.input :notifications_sent_at, :as => :string, :hint => 'Keep this blank for delivery/re-delivery of notifications'
      f.input :ready_for_reminders
    end

    f.actions
  end
end
