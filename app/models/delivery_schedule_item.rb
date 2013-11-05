class DeliveryScheduleItem < ActiveRecord::Base
  belongs_to :delivery_schedule
  belongs_to :customer
  
  # belongs_to :finished_good
  belongs_to :item, :polymorphic => true
  
  has_many :finished_good_transactions, :dependent => :destroy
  
  validates :customer, :item, :quantity, :presence => true
  validates :quantity, :numericality => true
  validates :po, :so, :length => {:maximum => 30}, :allow_nil => true, :allow_blank => true
  
  after_update :remove_finished_good_transactions
  
  protected
  
  def remove_finished_good_transactions
    self.finished_good_transactions.each do |fgt|
      fgt.destroy
    end
  end
end
