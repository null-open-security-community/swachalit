class CreateEventRegistrations < ActiveRecord::Migration
  def change
    create_table :event_registrations do |t|
      t.references :event
      t.references :user
      t.boolean :visible, :default => true

      t.timestamps
    end
  end
end
