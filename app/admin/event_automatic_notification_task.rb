ActiveAdmin.register EventAutomaticNotificationTask do
  menu :label => 'Automatic Notification Task', :parent => 'Tasks'

  index do
    column :id
    column :event
    column :mode
    column :executed

    default_actions
  end

  form do |f|
    f.inputs "Note" do
      %Q|
      <p style='padding: 1em;'>
        This task is internally used for delivering <strong>Automatic Notifications</strong>. 
        Currently the automatic notification system is disabled due to lack of testing. This form
        can be used to manually trigger an appropriate notification task corresponding to an <strong>Event</strong>.
        The task will be processed <strong>immediately</strong> after it is created or edited as long as <strong>executed</strong>
        is unchecked.
      </p>
      |.html_safe
    end

    f.inputs "Automatic Notification Task" do
      f.input :event, :as => :select, :collection => Event.future_events
      f.input :mode, :as => :select, :collection => EventAutomaticNotificationTask::MODE_ALL
      f.input :executed
    end

    f.actions
  end
end
