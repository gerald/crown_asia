class Bag < ActiveRecord::Base
  belongs_to :removing_transaction, :class_name => "FinishedGoodTransaction"
  belongs_to :finished_good
  belongs_to :finished_good_transaction_item
  
  validates :quantity, :numericality => true
  
  acts_as_paranoid
  
  acts_as_audited
  
  def return
    self.removing_transaction = nil
    self.save
  end
end
