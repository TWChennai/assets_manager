class Project < ActiveRecord::Base
  attr_protected
  has_many :assets

  validates :email, :name,
            :presence =>  true
end
