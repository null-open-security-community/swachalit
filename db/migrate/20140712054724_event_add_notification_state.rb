class EventAddNotificationState < ActiveRecord::Migration
  def up
    add_column :events, :notification_state, :string
  end

  def down
    remove_column :events, :notification_state
  end
end
