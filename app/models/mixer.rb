class Mixer < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  validates :name, :brand, :presence => true
  
  scope :active_mixers, :conditions => {:active => true}, :order => "name"
end
