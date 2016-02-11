class CreateTestObjects < ActiveRecord::Migration
  def change
    create_table :test_objects, id: false do |t|
      t.string  :id, primary_key: true, unique: true
      t.string  :title, null: false
      t.string  :user_id, null: false
      t.datetime :ts, null: false, limit: 6
      t.boolean :is_deleted, null: false, default: 0
    end
    execute 'ALTER TABLE test_objects ADD PRIMARY KEY (id);'
  end

  def down
    drop_table :test_objects
  end
end