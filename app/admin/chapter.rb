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
    column :country do |chapter|
      chapter.country_name
    end
    column :active

    actions
  end
end
