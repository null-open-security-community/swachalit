class EditUserRegistrations < ActiveRecord::Migration
  def up
    add_column :event_registrations, :gov_id_type,    :string
    add_column :event_registrations, :gov_id_number,  :string
  end

  def down
    remove_column :event_registrations, :gov_id_type
    remove_column :event_registrations, :gov_id_number
  end
end
