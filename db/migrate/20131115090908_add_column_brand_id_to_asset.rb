class AddColumnBrandIdToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :brand_id, :integer
  end
end
