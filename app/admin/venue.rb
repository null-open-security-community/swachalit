ActiveAdmin.register Venue do
  menu :priority => 4

  index do
    column :id
    column :chapter
    column :name
    column :contact_name
    column :contact_mobile

    default_actions
  end
end
