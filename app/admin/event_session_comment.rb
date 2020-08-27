ActiveAdmin.register EventSessionComment do
  menu :label => 'Event Session Comment List', :parent => 'Events'

  index do
    column :id
    column :event_session
    column :user
    column :comment_body
    actions
  end
end