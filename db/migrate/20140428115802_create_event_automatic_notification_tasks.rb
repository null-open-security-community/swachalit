class CreateEventAutomaticNotificationTasks < ActiveRecord::Migration
  def change
    create_table :event_automatic_notification_tasks do |t|
      t.integer :event_id
      t.string  :mode
      t.boolean :executed, :default => false
      
      t.timestamps
    end
  end
end
