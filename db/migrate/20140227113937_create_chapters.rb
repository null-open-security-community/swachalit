class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :code
      t.string :description
      t.string :city
      t.string :state
      t.string :country
      t.datetime :birthday
      t.boolean :active, :default => true
      
      t.timestamps
    end
  end
end
