# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  employee_id :string
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string
#  admin       :boolean
#

class User < ActiveRecord::Base
  default_scope { order :name }

  has_many :assets

  validates :name, :employee_id,
            :presence => true

  # TODO: Convert to scope
  def self.admins
    where(:admin => true)
  end

  def email
    "#{employee_id}@thoughtworks.com"
  end

  def to_s
    name
  end

  def owned_assets
    assets.assigned_to_individuals
  end

  def self.by_employee_id(employee_id)
    where(:employee_id =>  employee_id).first
  end
end
