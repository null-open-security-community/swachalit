class CreateEventMailerTasks < ActiveRecord::Migration
  def change
    create_table :event_mailer_tasks do |t|
      t.references :event
      t.string  :subject
      t.text    :body
      t.boolean :send_to_selected_only, :default => false
      t.boolean :ready_for_delivery, :default => false
      t.boolean :executed, :default => false  # Flag to identify completion
      t.string  :status

      t.timestamps
    end
  end
end
