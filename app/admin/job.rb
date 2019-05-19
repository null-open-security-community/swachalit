ActiveAdmin.register Job do
  menu :priority => 90

  config.clear_action_items!
  #actions :index
  #actions :show
  actions :all, except: [:edit]

  index do
    column :id
    column :name
    column :type
    column("State") {|job| job.state_name }

    actions
  end
end
