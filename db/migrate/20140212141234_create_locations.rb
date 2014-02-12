class CreateLocations < ActiveRecord::Migration
  def up
    create_table :locations do |t|
      t.string :name

      t.timestamps
    end

    remove_column :assets, :location
    add_column :assets, :location_id, :integer

    chennai = Location.create! :name => "Chennai"
    bng     = Location.create! :name => "Bangalore"
    Asset.update_all :location_id => chennai.id
  end

  def down
    remove_column :assets, :location_id
    add_column :assets, :location, :string
    drop_table :locations
  end
end
