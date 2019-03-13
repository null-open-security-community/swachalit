class EditEventForNotification < ActiveRecord::Migration
  def up
    add_column :events, :ready_for_announcement, :boolean, :default => false
    add_column :events, :announced_at, :datetime
    add_column :events, :ready_for_notifications, :boolean, :default => false
    add_column :events, :notifications_sent_at, :datetime
    add_column :events, :ready_for_reminders, :boolean
  end

  def down
    remove_column :events, :ready_for_announcement
    remove_column :events, :announced_at
    remove_column :events, :ready_for_notifications
    remove_column :events, :notifications_sent_at
    remove_column :events, :ready_for_reminders
  end
end
