ActiveAdmin.register User do
  menu :priority => 100

  filter :email
  filter :name

  index do
    column :id
    column :name
    column :email
    column :current_sign_in_ip
    column :current_sign_in_at
    column :created_at
    
    default_actions
  end
end
