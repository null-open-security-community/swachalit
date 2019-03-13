class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.integer :chapter_id
      t.string :name
      t.text :description
      t.text :address
      t.string :map_url
      t.text :map_embedd_code
      t.integer :chapter_id
      t.string :contact_name
      t.string :contact_email
      t.string :contact_mobile
      t.text :contact_notes

      t.timestamps
    end
  end
end
