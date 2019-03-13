class EventSessionAddPresentationUrl < ActiveRecord::Migration
  def up
    add_column :event_sessions, :presentation_url, :string
  end

  def down
    remove_column :event_sessions, :presentation_url
  end
end
