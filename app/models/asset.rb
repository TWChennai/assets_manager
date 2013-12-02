class Asset < ActiveRecord::Base
  attr_protected

  belongs_to :asset_type
  belongs_to :user
  belongs_to :project
  belongs_to :brand

  module Status
    ASSIGNED     = 'Assigned'
    IN_STOCK     = 'In Stock'
    OUT_OF_ORDER = 'Out of order'
  end

  VALID_STATUSES = [Status::ASSIGNED, Status::IN_STOCK, Status::OUT_OF_ORDER]

  validates :status, :asset_type, :bar_code,
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
    includes(:asset_type).where(:asset_types => {:common_resource => true }).order('asset_types.name')
  end

  def assigned_to?(user)
    user.assets.include?(self)
  end

  def unassign!
    self.user     = nil
    self.project  = nil
    self[:status] = Status::IN_STOCK
    self.save!
  end

  def assign!(user, project)
    self.user    = user
    self.project = project
    self.status  = Status::ASSIGNED
    self.save!
  end

  def owner
    project || user
  end

  def name
    "#{asset_type.name} - #{bar_code}"
  end
end
