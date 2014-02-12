class Location < ActiveRecord::Base
  attr_protected

  validates :name,
            :presence => true

  def self.with_name(name)
    where(:name => name.to_s.titleize).first
  end

  def self.const_missing(sym)
    const_set sym, with_name(sym)
  end
end
