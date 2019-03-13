class CreateEventSessions < ActiveRecord::Migration
  def change
    create_table :event_sessions do |t|
      t.integer :event_id
      t.integer :user_id

      t.string :name
      t.string :session_type
      t.text :description
      t.string :tags

      t.boolean :need_projector, :default => false
      t.boolean :need_microphone, :default => false
      t.boolean :need_whiteboard, :default => false

      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
