ActiveAdmin.register PageAccessPermission do
  menu :label => 'Page Access Permissions', :parent => 'Pages'

  filter :page
  filter :id

  index do
    column :id
    column :page
    column :user
    column :permission_type

    actions
  end

  form do |f|
    f.inputs "Permission Info" do
      f.input :page
      f.input :user, :as => :select, :collection => User.order('name ASC').map {|u| ["#{u.name} <#{u.email}>", u.id] }
      f.input :permission_type, :as => :select, :collection => ::PageAccessPermission::PERM_ALL

      f.actions
    end
  end

end
