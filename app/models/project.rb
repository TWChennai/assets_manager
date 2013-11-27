class Project < ActiveRecord::Base
  attr_protected

  default_scope { order :name }

  has_many :assets

  validates :email, :name,
            :presence =>  true

end
