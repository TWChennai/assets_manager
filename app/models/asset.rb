class Asset < ActiveRecord::Base
  attr_accessible :description, :status, :asset_type_id, :employee_id, :bar_code, :serial_number
  belongs_to :asset_type
  belongs_to :user
  belongs_to :project

  VALID_STATUSES = ['Assigned', 'In Stock', 'Out of order']

  validates :status, :asset_type,
            :presence => true
end
