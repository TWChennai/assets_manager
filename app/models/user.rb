class User < ActiveRecord::Base
  has_many :assets

  validates :name, :employee_id,
            :presence => true
  
  def email
    "#{employee_id}@thoughtworks.com"
  end

  def self.by_employee_id(employee_id)
    where(:employee_id =>  employee_id).first
  end
end
