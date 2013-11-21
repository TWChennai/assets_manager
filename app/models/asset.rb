class Asset < ActiveRecord::Base
  attr_accessible :description, :status, :asset_type_id, :employee_id, :bar_code, :serial_number, :user_id, :brand_id
  belongs_to :asset_type
  belongs_to :user
  belongs_to :project
  belongs_to :brand

  VALID_STATUSES = ['Assigned', 'In Stock', 'Out of order']

  validates :status, :asset_type,
            :presence => true

  def self.assigned_to_individuals
    where(:project_id => nil)
  end

  def user_id=(value)
    super(value)
    self.status = 'Assigned' if value.present?
  end

  def self.by_bar_code(bar_code)
    where(:bar_code =>  bar_code).first
  end

  def assigned_to?(user)
    user.assets.include?(self)
  end

  def unassign!
    self.user_id = nil
    self.project_id = nil
    self.save!
  end

  def assign!(user, project)
    self.user = user
    self.project = project
    self.save!
  end

  def owner
    project || user
  end

  def name
    "#{asset_type.name} - #{bar_code}"
  end
end