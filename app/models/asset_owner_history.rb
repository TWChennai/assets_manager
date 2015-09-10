# == Schema Information
#
# Table name: asset_owner_histories
#
#  id         :integer          not null, primary key
#  owner_id   :integer
#  owner_type :string
#  asset_id   :integer
#  event      :string           not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_asset_owner_histories_on_asset_id                 (asset_id)
#  index_asset_owner_histories_on_owner_id_and_owner_type  (owner_id,owner_type)
#  index_asset_owner_histories_on_owner_type_and_owner_id  (owner_type,owner_id)
#


class AssetOwnerHistory < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  belongs_to :asset

  module EVENTS
    ASSIGNED = 'ASSIGNED'.freeze
    RETURNED = 'RETURNED'.freeze
    ALL = [ASSIGNED, RETURNED]
  end

  def self.create_returned_event(options)
    create! options.merge :event => EVENTS::RETURNED
  end

  def self.create_assigned_event(options)
    create! options.merge :event => EVENTS::ASSIGNED
  end
end
