class Location < ActiveRecord::Base
  attr_protected

  validates :name,
            :presence => true

  def self.const_missing(sym)
    const_set(sym, where(:name => sym.to_s.titleize))
  end
end
