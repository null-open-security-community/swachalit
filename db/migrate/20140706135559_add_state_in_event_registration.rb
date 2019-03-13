class AddStateInEventRegistration < ActiveRecord::Migration
  def up
    add_column :event_registrations, :state, :string
  end

  def down
    remove_column :event_registrations, :state
  end
end
