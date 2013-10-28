class Project < ActiveRecord::Base
  attr_protected
  has_many :assets
end
