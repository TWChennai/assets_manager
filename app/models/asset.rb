# == Schema Information
#
# Table name: assets
#
#  id            :integer          not null, primary key
#  bar_code      :string
#  asset_type_id :integer
#  status        :string
#  description   :text
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#  serial_number :string
#  project_id    :integer
#  brand_id      :integer
#  location_id   :integer
#
# Indexes
#
#  index_assets_on_asset_type_id  (asset_type_id)
#  index_assets_on_brand_id       (brand_id)
#  index_assets_on_location_id    (location_id)
#  index_assets_on_project_id     (project_id)
#  index_assets_on_user_id        (user_id)
#

class Asset < ActiveRecord::Base
  default_scope { includes :asset_type }
  scope :assigned_to_individuals, -> { where(project_id: nil) }

  belongs_to :asset_type
  belongs_to :user
  belongs_to :project
  belongs_to :brand
  belongs_to :location

  has_many :owner_history, :class_name => "AssetOwnerHistory"

  module Status
    ASSIGNED     = 'Assigned'
    BORROWED     = 'Borrowed'
    IN_STOCK     = 'In Stock'
    OUT_OF_ORDER = 'Out of order'
    IN_SERVICE   = 'In Service'
  end

  # TODO: Move these to the Location model
  LOCATION = ["Chennai", "Bangalore"]

  VALID_STATUSES = [Status::ASSIGNED, Status::BORROWED, Status::IN_STOCK, Status::OUT_OF_ORDER, Status::IN_SERVICE]

  validates :status, :asset_type, :bar_code, :location, :presence => true

  validates :bar_code, uniqueness: { case_sensitive: false }

  before_save do |record|
    record.status = Status::ASSIGNED if record.user_id_changed? && record.user_id.present?
    record.user_id = record.project_id = nil if record.status_changed? && record.status == Status::IN_STOCK
    true
  end

  # TODO: Convert to scopes
  def self.by_bar_code(bar_code)
    where(["LOWER(bar_code) = ?", bar_code.downcase]).first
  end

  def self.common
    _common.includes(:asset_type).order('asset_types.name')
  end

  def self.indivduals_usage_summary
    self
      .unscoped
      .assigned_to_individuals
      .select('users.name as user_name, users.id as user_id, asset_types.name as asset_name, count(*) as count')
      .joins([:asset_type, :user])
      .where(:status => Status::ASSIGNED)
      .group('users.id, users.name, asset_types.name')
      .order('count desc')
  end

  def self.common_usage_summary
    _common.indivduals_usage_summary
  end

  def self._common
    where(:asset_types => {:common_resource => true })
  end

  def assigned_to?(user)
    user.assets.include?(self)
  end

  def borrowed?
    status == Status::BORROWED
  end

  def assign_permanent!
    return unless self.user
    self[:status] = Status::ASSIGNED
    save!
  end

  def unassign!
    previous_owner = self.owner
    self.user     = nil
    self.project  = nil
    self[:status] = Status::IN_STOCK
    self.save!
    AssetOwnerHistory.create_returned_event :owner => previous_owner, :asset => self
  end

  def assign!(user, project = nil, borrow = false)
    self.user    = user
    self.project = project
    self.status  = borrow ? Status::BORROWED : Status::ASSIGNED
    self.save!
    AssetOwnerHistory.create_assigned_event :owner => owner, :asset => self
  end

  def owner
    project || user
  end

  def name
    "#{asset_type.name} - #{bar_code}"
  end
end
