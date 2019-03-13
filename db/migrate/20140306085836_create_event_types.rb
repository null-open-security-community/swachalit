class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :name
      t.text :description
      t.integer :max_participant, :default => 10000
      t.boolean :public   # Events of this type will show up in home page
      t.boolean :registration_required, :default => false
      t.boolean :invitation_required, :default => false

      t.timestamps
    end
  end
end
