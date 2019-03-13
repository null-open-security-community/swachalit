class CreateChapterLeads < ActiveRecord::Migration
  def change
    create_table :chapter_leads do |t|
      t.integer :user_id
      t.integer :chapter_id
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
