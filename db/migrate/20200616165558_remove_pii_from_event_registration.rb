class RemovePiiFromEventRegistration < ActiveRecord::Migration
  def change
    remove_column :event_registrations, :gov_id_type, :string
    remove_column :event_registrations, :gov_id_number, :string
  end
end
