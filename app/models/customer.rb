class Customer < ActiveRecord::Base

  validates :name, :presence => true

  has_many :sent_raw_material_transactions, :as => :sender
  has_many :sent_finished_good_transactions, :as => :sender
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  scope :active_customers, :conditions => {:active => true}
  
end
