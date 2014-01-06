class AssetType < ActiveRecord::Base
  attr_protected

  default_scope { order :name }
end