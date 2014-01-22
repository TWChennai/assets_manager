class AddLocationToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :location, :string
  end
end