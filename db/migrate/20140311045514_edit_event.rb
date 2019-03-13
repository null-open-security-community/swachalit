class EditEvent < ActiveRecord::Migration
  def up
    add_column :events, :registration_start_time, :datetime
    add_column :events, :registration_end_time, :datetime
    add_column :events, :registration_instructions, :text
  end

  def down
    remove_column :events, :registration_start_time
    remove_column :events, :registration_end_time
    remove_column :events, :registration_instructions
  end
end
