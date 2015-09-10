class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :assets, :asset_type_id
    add_index :assets, :user_id
    add_index :assets, :project_id
    add_index :assets, :brand_id
    add_index :assets, :location_id
    add_index :projects, :location_id
  end
end
