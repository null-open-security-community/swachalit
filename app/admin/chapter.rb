ActiveAdmin.register Chapter do
  menu :label => 'Chapter List', :parent => 'Chapters'

  filter :name
  filter :code
  filter :active

  index do
    column :id
    column :code
    column :name
    column :city
    column :active

    default_actions
  end
end
