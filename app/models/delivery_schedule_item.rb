class DeliveryScheduleItem < ActiveRecord::Base
  belongs_to :delivery_schedule
  belongs_to :customer
  
  # belongs_to :finished_good
  belongs_to :item, :polymorphic => true
  
  has_many :finished_good_transactions
  
  validates :customer, :item, :quantity, :presence => true
  validates :quantity, :numericality => true
  validates :po, :so, :length => {:maximum => 30}, :allow_nil => true, :allow_blank => true
  
  after_destroy :return_removed_bags
  
  protected
  
  def return_removed_bags
    self.finished_good_transactions.each do |fgt|
      fgt.removed_bags.each do |bag|
        bag.return
      end
    end
  end
end
