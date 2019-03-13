class AddRequiredStateForEventUserMailer < ActiveRecord::Migration
  def up
    add_column :event_mailer_tasks, :registration_state, :string
  end

  def down
    remove_column :event_mailer_tasks, :registration_state
  end
end
