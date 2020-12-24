ActiveAdmin.register EventSessionComment do
  menu :label => 'Event Session Comment List', :parent => 'Events'

  # We will not allow admins to edit comment as it violates non-repudiation
  # Admin can however delete comments if they need to
  controller do
    actions :all, :except => [:edit]
  end

  index do
    column :id
    column :event_session
    column :user
    column :comment_body
    actions
  end
end
