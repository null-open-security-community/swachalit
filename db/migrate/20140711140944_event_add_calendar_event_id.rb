class EventAddCalendarEventId < ActiveRecord::Migration
  def up
    add_column :events, :calendar_event_id, :string
  end

  def down
    remove_column :events, :calendar_event_id
  end
end
