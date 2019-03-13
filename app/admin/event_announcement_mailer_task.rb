ActiveAdmin.register EventAnnouncementMailerTask do
  menu :label => 'Event Announcement Mailer', :parent => 'Tasks'

  index do
    column :id
    column :event
    column :recipients
    column :ready_for_delivery
    column :executed

    default_actions
  end

  form do |f|
    f.inputs "Event Announcement Mailer" do
      f.input :event
      f.input :recipients
      f.input :head_note
      f.input :foot_note
      f.input :ready_for_delivery
      f.input :executed
    end

    f.actions
  end
end
