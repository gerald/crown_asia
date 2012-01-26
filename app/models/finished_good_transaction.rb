class FinishedGoodTransaction < ActiveRecord::Base
  belongs_to :finished_good
  belongs_to :sender, :polymorphic => true
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  has_many :added_bags, :foreign_key => "adding_transaction_id", :class_name => "Bag", :dependent => :destroy
  has_many :removed_bags, :foreign_key => "removing_transaction_id", :class_name => "Bag", :dependent => :nullify
  
  validates_with BagRangeValidator
  
  validates :transaction_date, :quantity, :lot_number, :presence => true
  
  validates :reference_type, :reference_number, :start_bag_number, :end_bag_number, :sender, :quantity_per_bag, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :start_bag_number, :end_bag_number, :quantity_per_bag, :numericality => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :remainder_quantity, :numericality => true, :allow_nil => true, :allow_blank => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :reference_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  
  validates :dr_number, :si_number, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  validates :dr_number, :si_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  
  validates :quantity, :numericality => true
  
  after_create :create_bags
  before_validation :set_quantity
  
  acts_as_paranoid

  def removed_bag_numbers
    return nil if self.transaction_type != "sub"
    first_bag = Bag.first(:conditions => ["removing_transaction_id = ?", self.id], :order => "bag_number")
    last_bag = Bag.last(:conditions => ["removing_transaction_id = ?", self.id], :order => "bag_number")
    return first_bag.bag_number if last_bag.nil?
    return last_bag.bag_number if first_bag.nil?
    return "#{first_bag.bag_number} - #{last_bag.bag_number}"
  end
  
  protected
    def create_bags
      return if self.transaction_type != "add"
      self.start_bag_number.upto(self.end_bag_number) do |i|
        Bag.create(:bag_number => i, :adding_transaction => self, :finished_good => self.finished_good, :quantity => self.quantity_per_bag)
      end
      Bag.create(:bag_number => 0, :adding_transaction => self, :finished_good => self.finished_good, :quantity => self.remainder_quantity) if !self.remainder_quantity.blank?
    end
    
    def set_quantity
      if self.transaction_type == "sub"
        self.quantity = Bag.sum("quantity", :conditions => ["ID IN(?)", self.removed_bag_ids])
      else
        self.quantity = (((self.end_bag_number - self.start_bag_number) + 1) * self.quantity_per_bag) + self.remainder_quantity
      end
    end
end
