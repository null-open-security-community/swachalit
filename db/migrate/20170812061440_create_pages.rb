class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string  :name
      t.text    :description
      t.string  :navigation_name
      t.string  :slug
      
      t.string  :title
      t.text    :content, :limit => 4294967295
      t.boolean :published
      
      t.timestamps
    end
  end
end
