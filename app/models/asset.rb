class Asset < ActiveRecord::Base
  attr_protected

  belongs_to :asset_type
  belongs_to :user
  belongs_to :project
  belongs_to :brand
  belongs_to :location

  has_many :owner_history, :class_name => "AssetOwnerHistory"

  module Status
    ASSIGNED     = 'Assigned'
    IN_STOCK     = 'In Stock'
    OUT_OF_ORDER = 'Out of order'
    IN_SERVICE   = 'In Service'
  end

  LOCATION = ["Chennai", "Bangalore"]

  VALID_STATUSES = [Status::ASSIGNED, Status::IN_STOCK, Status::OUT_OF_ORDER, Status::IN_SERVICE]

  validates :status, :asset_type, :bar_code, :location,
            :presence => true

  validates :bar_code,
            :uniqueness => true

  before_save do |record|
    record.status = Status::ASSIGNED if record.user_id_changed? && record.user_id.present?
    record.user_id = record.project_id = nil if record.status_changed? && record.status == Status::IN_STOCK
    true
  end

  def self.assigned_to_individuals
    where(:project_id => nil)
  end

  def self.by_bar_code(bar_code)
    where(:bar_code => bar_code).first
  end

  def self.common
    _common.includes(:asset_type).order('asset_types.name')
  end

  def self.indivduals_usage_summary
    assigned_to_individuals
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

  def unassign!
    previous_owner = self.owner
    self.user     = nil
    self.project  = nil
    self[:status] = Status::IN_STOCK
    self.save!
    AssetOwnerHistory.create_returned_event :owner => previous_owner, :asset => self
  end

  def assign!(user, project)
    self.user    = user
    self.project = project
    self.status  = Status::ASSIGNED
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
