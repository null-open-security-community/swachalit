ActiveAdmin.register EventRegistration do
  menu :label => 'Event Registrations', :parent => 'Events'
  config.per_page = 100

  filter :event
  filter :user
  filter :state, :as => :check_boxes, :collection => proc { EventRegistration::STATE_ALL }
  filter :created_at
  filter :updated_at

  # DEPRECATED
  # batch_action :accept do |selection|
  #   EventRegistration.find(selection).each do |er|
  #     er.accepted!
  #   end

  #   redirect_to collection_path
  # end

  # batch_action :reject do |selection|
  #   EventRegistration.find(selection).each do |er|
  #     er.rejected!
  #   end

  #   redirect_to collection_path
  # end

  batch_action :provision do |selection|
    EventRegistration.find(selection).each do |event_registration|
      event_registration.set_state!(EventRegistration::STATE_PROVISIONAL)
    end
    redirect_to collection_path
  end

  batch_action :confirm do |selection|
    EventRegistration.find(selection).each do |event_registration|
      event_registration.set_state!(EventRegistration::STATE_CONFIRMED)
    end
    redirect_to collection_path
  end

  batch_action :not_attending do |selection|
    EventRegistration.find(selection).each do |event_registration|
      event_registration.set_state!(EventRegistration::STATE_NOT_ATTENDING)
    end
    redirect_to collection_path
  end

  batch_action :absent do |selection|
    EventRegistration.find(selection).each do |event_registration|
      event_registration.set_state!(EventRegistration::STATE_ABSENT)
    end
    redirect_to collection_path
  end

  scope :user_joined, :default => true do |event_registrations|
    event_registrations.includes [:user]  
  end

  index do
    selectable_column
    column :id
    column :event
    column :user, :sortable => 'users.name'
    column :state
    column :created_at

    default_actions
  end

  form do |f|
    f.inputs "Note" do
      %Q|
        <p style='padding: 1em;'>
        Editing this entry is not allowed. Please use <strong>Batch Actions</strong> for state update.
        </p>
      |.html_safe
    end

    f.inputs do
      f.input :event, :input_html => { :disabled => true }
      f.input :user, :input_html => { :disabled => true }
      f.input :visible, :input_html => { :disabled => true }
      f.input :state, :as => :select, :collection => EventRegistration::STATE_ALL, :input_html => { :disabled => true }
    end

    f.actions
  end
end
