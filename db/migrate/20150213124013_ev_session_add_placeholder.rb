class EvSessionAddPlaceholder < ActiveRecord::Migration
  def up
    add_column :event_sessions, :placeholder, :boolean, :default => false
  end

  def down
    remove_column :event_sessions, :placeholder
  end
end
