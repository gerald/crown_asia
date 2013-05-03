class CoqProperty < ActiveRecord::Base
  acts_as_tree :order => "position"
  
  validates :name, :presence => true
  validates :position, :presence => true
  validates :position, :numericality => true
end
