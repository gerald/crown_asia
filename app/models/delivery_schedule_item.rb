class DeliveryScheduleItem < ActiveRecord::Base
  belongs_to :delivery_schedule
  belongs_to :customer
  belongs_to :finished_good
  
  has_one :finished_good_transaction
  
  validates :customer, :finished_good, :quantity, :presence => true
  validates :quantity, :numericality => true
  validates :po, :so, :length => {:maximum => 30}, :allow_nil => true, :allow_blank => true
end
