ActiveAdmin.register User do
  menu :priority => 100

  filter :email
  filter :name

  batch_action :confirm do |selection|
    
    ::User.find(selection).each do |user|
      user.confirm()
    end

    redirect_to collection_path
  end

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :confirmed?
    column :current_sign_in_ip
    column :current_sign_in_at
    column :created_at
    
    actions
  end

  form do |f|
    f.inputs "User Info" do
      f.input :name
      f.input :email
    end

    f.inputs "Password" do
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end

  show do
    h3 "Basic Info"
    div do
      attributes_table do
        row :id
        row :name
        row :email
        row :homepage
        row :about_me
        row :twitter_handle
        row :facebook_profile
        row :github_profile
        row :linkedin_profile
        row :handle
        row :avatar
      end
    end

    h3 "System Internals"
    div do
      attributes_table do
        row :reset_password_sent_at
        row :current_sign_in_at
        row :last_sign_in_at
        row :current_sign_in_ip
        row :confirmed_at
        row :confirmation_sent_at
        row :unconfirmed_email
        row :failed_attempts
        row :locked_at
      end
    end
  end

end
