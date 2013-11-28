class AddColumnCommonResourceToAssetTypes < ActiveRecord::Migration
  def change
    add_column :asset_types, :common_resource, :boolean
  end
end
