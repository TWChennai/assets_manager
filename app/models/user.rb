class User < ActiveRecord::Base
  attr_protected

  default_scope { order :name }

  has_many :assets

  validates :name, :employee_id,
            :presence => true

  def email
    "#{employee_id}@thoughtworks.com"
  end

  def owned_assets
    assets.assigned_to_individuals
  end

  def self.by_employee_id(employee_id)
    where(:employee_id =>  employee_id).first
  end
end
