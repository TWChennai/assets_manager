class AddProjectIdToAssets < ActiveRecord::Migration
  def change
  	add_column :assets, :project_id, :integer
  end
end
