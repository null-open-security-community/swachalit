class EditEventAnnouncement < ActiveRecord::Migration
  def up
    add_column :event_announcement_mailer_tasks, :head_note, :text
  end

  def down
    remove_column :event_announcement_mailer_tasks, :head_note
  end
end
