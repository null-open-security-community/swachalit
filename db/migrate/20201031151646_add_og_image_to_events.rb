class AddOgImageToEvents < ActiveRecord::Migration
  def change
    add_column :events, :image, :string
    add_column :event_sessions, :image, :string
  end
end
