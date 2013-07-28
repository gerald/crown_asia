class Personnel < ActiveRecord::Base
  validates :first_name, :last_name, :position, :presence => true
  
  belongs_to :position
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  
  def last_name_first
    "#{self.last_name}, #{self.first_name}"
  end
end
