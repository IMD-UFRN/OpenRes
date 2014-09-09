class CreateClassMonitors < ActiveRecord::Migration
  def change
    create_table :class_monitors do |t|

      t.string :name
      t.string :email

      t.references :place, index: true

      t.timestamps
    end
  end
end
