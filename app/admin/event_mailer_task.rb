ActiveAdmin.register EventMailerTask do
  menu :label => 'Event User Mailer', :parent => 'Tasks'

  form do |f|
    f.inputs "Note" do
      %Q|
      <p style='padding: 1em;'>
        <strong>This mailer task has been updated: </strong> Email will be sent to all or registrations
        or selected state only.
      </p>
      |.html_safe
    end

    f.inputs do
      f.input :event
      f.input :subject
      f.input :body
      f.input :registration_state, :as => :select, :collection => EventRegistration::STATE_ALL, 
        :hint => "Keep this blank to send to all registered users."
      f.input :ready_for_delivery
      f.input :executed
    end

    f.actions
  end

  index do
    column :id
    column :event
    column :subject
    column :registration_state
    column :ready_for_delivery
    column :executed

    default_actions
  end
end

