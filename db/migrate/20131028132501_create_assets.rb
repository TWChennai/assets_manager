class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :bar_code
      t.string :asset_type
      t.string :status
      t.text :description

      t.timestamps
    end
  end
end
