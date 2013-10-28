class User < ActiveRecord::Base
  has_many :assets

  def self.by_employee_id(employee_id)
    where(:employee_id =>  employee_id).first
  end
end
