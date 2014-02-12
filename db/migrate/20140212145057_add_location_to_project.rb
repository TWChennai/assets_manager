class AddLocationToProject < ActiveRecord::Migration
  def up
    add_column :projects, :location_id, :integer
    Project.update_all :location_id => Location::Chennai.id
  end

  def down
    remove_column :projects, :location_id
  end
end
