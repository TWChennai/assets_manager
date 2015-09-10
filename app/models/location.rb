# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Location < ActiveRecord::Base
  validates :name, :presence => true
  scope :with_name, ->(name) { where(name: name.to_s.titleize).first }

  def self.const_missing(sym)
    const_set sym, with_name(sym)
  end
end
