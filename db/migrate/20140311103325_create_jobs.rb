class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string  :name,          :limit => 32
      t.string  :type
      t.string  :callback_path, :limit => 1000
      t.integer :state,         :default => 0
      t.binary  :params
      t.binary  :response
      t.string  :error_message
      t.text    :error_detail

      t.timestamps
    end
  end
end
