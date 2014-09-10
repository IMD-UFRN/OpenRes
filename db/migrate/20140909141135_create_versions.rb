# -*- encoding : utf-8 -*-
class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string   :item_type, :null => false
      t.integer  :item_id,   :null => false
      t.string   :event,     :null => false
      t.string   :whodunnit
      t.text     :object
      t.text     :object_changes
      t.datetime :created_at
      t.string   :responsible
      t.string   :reason
      t.string   :status
    end
    add_index :versions, [:item_type, :item_id]
  end
end
