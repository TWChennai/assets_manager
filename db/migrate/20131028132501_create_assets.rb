class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :bar_code
      t.references :asset_type
      t.string :status
      t.text :description
      t.references :user

      t.timestamps
    end
  end
end
