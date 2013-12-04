class CreateAssetOwnerHistories < ActiveRecord::Migration
  def change
    create_table :asset_owner_histories do |t|
      t.references :owner, polymorphic: true, index: true
      t.references :asset, index: true
      t.string :event, null: false

      t.timestamps
    end
  end
end
