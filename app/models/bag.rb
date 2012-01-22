class Bag < ActiveRecord::Base
  belongs_to :adding_transaction, :class_name => "FinishedGoodTransaction"
  belongs_to :removing_transaction, :class_name => "FinishedGoodTransaction"
  belongs_to :finished_good
  
  validates :quantity, :numericality => true
  
  acts_as_paranoid
end
