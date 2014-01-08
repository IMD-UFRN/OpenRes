class CreateUserPlaces < ActiveRecord::Migration
  def change
    create_table :user_places do |t|
      t.string :code
      t.references :user

      t.timestamps
    end
  end
end
