class Project < ActiveRecord::Base
  attr_protected

  default_scope { order :name }

  has_many :assets
  belongs_to :location

  validates :email, :name, :location,
            :presence =>  true

end