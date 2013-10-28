class AddColumnSerialNumberToAssets < ActiveRecord::Migration
  def change
  	add_column :assets, :serial_number, :string
  end
end
