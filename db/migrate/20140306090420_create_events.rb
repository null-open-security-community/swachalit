class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :name
      t.text    :description
      t.integer :chapter_id
      t.integer :venue_id
      t.integer :event_type_id
      
      t.boolean :public
      t.boolean :can_show_on_homepage, :default => true
      t.boolean :can_show_on_archive, :default => true
      t.boolean :accepting_registration, :default => true

      t.string   :state
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
