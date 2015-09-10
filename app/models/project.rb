# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  created_at  :datetime
#  updated_at  :datetime
#  email       :string
#  location_id :integer
#
# Indexes
#
#  index_projects_on_location_id  (location_id)
#

class Project < ActiveRecord::Base
  default_scope { order :name }

  has_many :assets
  belongs_to :location

  validates :email, :name, :location,
            :presence =>  true
  # TODO: Email validator
end
