class EditEventRegistration < ActiveRecord::Migration
  def up
    add_column :event_registrations, :accepted, :boolean
  end

  def down
    remove_column :event_registrations, :accepted
  end
end
