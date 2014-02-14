class CreatePlaceObjects < ActiveRecord::Migration
  def change
    create_table :place_objects do |t|
      t.integer :object_resource_id
      t.integer :place_id
      t.references :object_resource
      t.references :place
    end
  end
end
