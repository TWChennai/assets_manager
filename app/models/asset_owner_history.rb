class AssetOwnerHistory < ActiveRecord::Base
  attr_protected

  belongs_to :owner, polymorphic: true
  belongs_to :asset

  module EVENTS
    ASSIGNED = "ASSIGNED"
    RETURNED = "RETURNED"
    ALL = [ASSIGNED, RETURNED]
  end

  def self.create_returned_event(options)
    create! options.merge :event => EVENTS::RETURNED
  end

  def self.create_assigned_event(options)
    create! options.merge :event => EVENTS::ASSIGNED
  end
end