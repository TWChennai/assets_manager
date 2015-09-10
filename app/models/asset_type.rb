# == Schema Information
#
# Table name: asset_types
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime
#  updated_at      :datetime
#  common_resource :boolean
#

class AssetType < ActiveRecord::Base
  default_scope { order :name }

  # TODO: Missing validations?
  validates :name, presence: true
end
