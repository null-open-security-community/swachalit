ActiveAdmin.register EventType do
  menu :label => 'Event Type List', :parent => 'Events'

  index do
    column :id
    column :name
    column :public
    column :created_at

    actions
  end
end
