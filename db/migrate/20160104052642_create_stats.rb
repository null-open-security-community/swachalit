class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|

      t.timestamps
    end
  end
end
