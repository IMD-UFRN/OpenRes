# -*- encoding : utf-8 -*-
class CreateObjectResources < ActiveRecord::Migration
  def change
    create_table :object_resources do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
