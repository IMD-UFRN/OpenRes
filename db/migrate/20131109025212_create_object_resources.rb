class CreateObjectResources < ActiveRecord::Migration
  def change
    create_table :object_resources do |t|
      t.string :name
      t.text :description
      t.references :sector, index: true
      t.references :place, index: true
      t.string :serial_number

      t.timestamps
    end
  end
end
