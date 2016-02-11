class CreateImitMods < ActiveRecord::Migration
  def change
    create_table :imit_mods do |t|

      t.timestamps null: false
    end
  end
end
