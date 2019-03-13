class CreateEventAnnouncementMailerTasks < ActiveRecord::Migration
  def change
    create_table :event_announcement_mailer_tasks do |t|
      t.references :event
      t.text :recipients
      t.text :foot_note
      t.boolean :ready_for_delivery, :default => false
      t.boolean :executed, :default => false  # Flag to identify completion
      t.string  :status

      t.timestamps
    end
  end
end
