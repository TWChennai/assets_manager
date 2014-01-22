class UpdateAllAssetsLocationToChennai < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute "update assets set location='Chennai'"
  end
end
