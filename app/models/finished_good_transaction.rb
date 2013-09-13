class FinishedGoodTransaction < ActiveRecord::Base
  belongs_to :finished_good
  belongs_to :sender, :polymorphic => true
  belongs_to :issued_to, :polymorphic => true
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  has_many :removed_bags, :foreign_key => "removing_transaction_id", :class_name => "Bag", :dependent => :nullify
  
  has_many :finished_good_transaction_items
  
  has_one :delivery_schedule_item
  
  accepts_nested_attributes_for :finished_good_transaction_items, :allow_destroy => true, :reject_if => lambda { |a| (a[:lot_number].blank? && a[:start_bag_number].blank? && a[:end_bag_number].blank? && a[:quantity].blank?) }
  
  validates :transaction_date, :presence => true
  
  validates :reference_type, :reference_number, :sender, :quantity_per_bag, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :quantity_per_bag, :numericality => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :reference_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  
  validates :issue_type, :issued_to, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  
  validates :dr_number, :si_number, :mirs_number, :format => {:with => /[0-9]+/}, :allow_nil => true, :allow_blank => true, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  
  #validates :dr_number, :si_number, :mirs_number, :format => {:with => /[0-9]+/}, :allow_nil => true, :allow_blank => true, :if => Proc.new { |transaction| transaction.issue_type == "Customer" && transaction.transaction_type == "sub" }
  
  # validates :mirs_number, :presence => true, :if => Proc.new { |transaction| transaction.issue_type == "Internal" && transaction.transaction_type == "sub" }
  # validates :mirs_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.issue_type == "Internal" && transaction.transaction_type == "sub" }
  
  validates :transaction_date, :reference_number, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "return" }
  validates :reference_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "return" }
  
  # validate :dr_or_si
  validate :bag_number_values
  validate :taken_bag_range
  validate :released_bag_range
  validate :return_bag_range
  validate :bag_number_existence
  validate :underpack_bag_quantity
  
  after_create :create_bags
  after_create :remove_bags
  after_create :return_bags
  
  acts_as_paranoid
  
  acts_as_audited :except => [:deleted_at]

  def removed_bag_numbers
    return nil if self.transaction_type != "sub"
    first_bag = Bag.first(:conditions => ["removing_transaction_id = ?", self.id], :order => "bag_number")
    last_bag = Bag.last(:conditions => ["removing_transaction_id = ?", self.id], :order => "bag_number")
    return first_bag.bag_number if last_bag.nil?
    return last_bag.bag_number if first_bag.nil?
    return "#{first_bag.bag_number} - #{last_bag.bag_number}"
  end
  
  # Custom validations
  def dr_or_si
    if self.issue_type == "Customer" && self.transaction_type == "sub" && self.dr_number.blank? && self.si_number.blank? && self.mirs_number.blank?
      errors.add(:base, "Must provide at least one of DR, SI, or MIRS number.")
    end
  end
  
  def bag_number_values
    self.finished_good_transaction_items.each do |item|
      next if item.underpack
      if item.end_bag_number < item.start_bag_number
        self.errors.add(:base, "End bag number cannot be greater than start bag number") 
        return
      end
    end
  end
  
  def taken_bag_range
    self.finished_good_transaction_items.each do |item|
      next if item.underpack
      if item.transaction_type == "add" && Bag.count(:include => [:finished_good], :conditions => ["bag_number >= ? AND bag_number <= ? AND bags.lot_number = ? AND finished_goods.id = ?", item.start_bag_number, item.end_bag_number, item.lot_number, self.finished_good_id]) > 0
        self.errors.add(:base, "Current range will use bag numbers that have already been taken") 
        return
      end
    end
  end
  
  def released_bag_range
    self.finished_good_transaction_items.each do |item|
      next if item.underpack
      if item.transaction_type == "sub" && Bag.count(:include => [:finished_good], :conditions => ["removing_transaction_id IS NOT NULL AND bag_number >= ? AND bag_number <= ? AND bags.lot_number = ? AND finished_goods.id = ?", item.start_bag_number, item.end_bag_number, item.lot_number, self.finished_good_id]) > 0
        self.errors.add(:base, "Current range will use bag numbers that have already been released") 
        return
      end
    end
  end
  
  def bag_number_existence
    self.finished_good_transaction_items.each do |item|
      next if item.underpack
      if item.transaction_type == "sub" && item.end_bag_number > item.start_bag_number && Bag.count(:include => [:finished_good], :conditions => ["bag_number >= ? AND bag_number <= ? AND bags.lot_number = ? AND finished_goods.id = ?", item.start_bag_number, item.end_bag_number, item.lot_number, self.finished_good_id]) != (item.end_bag_number - item.start_bag_number) + 1
        self.errors.add(:base, "Current range will use bag numbers that don't exist")
        return
      end
    end
  end
  
  def return_bag_range
    self.finished_good_transaction_items.each do |item|
      next if item.underpack
      if item.transaction_type == "return" && Bag.count(:include => [:finished_good], :conditions => ["removing_transaction_id IS NULL AND bag_number >= ? AND bag_number <= ? AND bags.lot_number = ? AND finished_goods.id = ?", item.start_bag_number, item.end_bag_number, item.lot_number, self.finished_good_id]) > 0
        self.errors.add(:base, "Current range will use bag numbers that have not been released yet.") 
        return
      end
    end
  end
  
  def underpack_bag_quantity
    return if self.transaction_type == "add" || self.transaction_type == "return"
    self.finished_good_transaction_items.each do |item|
      next if !item.underpack
      underpack_bag = Bag.first(:conditions => ["bags.finished_good_id = ? AND bags.lot_number = ? AND bag_number = 0", self.finished_good.id, item.lot_number])
      if underpack_bag.nil?
        self.errors.add(:base, "Underpack bag does not exist for that lot number") 
        return
      elsif item.quantity > underpack_bag.quantity
        self.errors.add(:base, "Quantity to be released cannot be greater than the current quantity of the underpack bag") 
        return
      end
    end
  end
  
  protected
    def create_bags
      return if self.transaction_type != "add"
      self.finished_good_transaction_items.each do |item|
        if item.underpack
          underpack_bag = Bag.first(:conditions => ["bags.finished_good_id = ? AND bags.lot_number = ? AND bag_number = 0", self.finished_good.id, item.lot_number])
          if underpack_bag.nil?
            Bag.create(:bag_number => 0, :finished_good => self.finished_good, :finished_good_transaction_item => item, :quantity => item.quantity, :lot_number => item.lot_number)
          else
            underpack_bag.update_attribute(:quantity, underpack_bag.quantity + item.quantity)
          end
        else
          item.start_bag_number.upto(item.end_bag_number) do |i|
            Bag.create(:bag_number => i, :finished_good => self.finished_good, :finished_good_transaction_item => item, :quantity => self.quantity_per_bag, :lot_number =>  item.lot_number)
          end
        end
      end
    end
    
    def remove_bags
      return if self.transaction_type != "sub"
      self.finished_good_transaction_items.each do |item|
        if item.underpack
          underpack_bag = Bag.first(:conditions => ["bags.finished_good_id = ? AND bags.lot_number = ? AND bag_number = 0", self.finished_good.id, item.lot_number])
          underpack_bag.update_attribute(:quantity, underpack_bag.quantity - item.quantity)
        else
          item.start_bag_number.upto(item.end_bag_number) do |i|
            bag = Bag.first(:conditions => ["lot_number = ? AND bag_number = ? AND finished_good_id = ?", item.lot_number, i, self.finished_good.id])
            bag.update_attribute(:removing_transaction_id, self.id)
          end
        end
      end
    end
    
    def return_bags
      return if self.transaction_type != "return"
      self.finished_good_transaction_items.each do |item|
        if item.underpack
          underpack_bag = Bag.first(:conditions => ["bags.finished_good_id = ? AND bags.lot_number = ? AND bag_number = 0", self.finished_good.id, item.lot_number])
          if underpack_bag.nil?
            Bag.create(:bag_number => 0, :finished_good => self.finished_good, :finished_good_transaction_item => item, :quantity => item.quantity, :lot_number => item.lot_number)
          else
            underpack_bag.update_attribute(:quantity, underpack_bag.quantity + item.quantity)
          end
        else
          item.start_bag_number.upto(item.end_bag_number) do |i|
            bag = Bag.first(:conditions => ["lot_number = ? AND bag_number = ? AND finished_good_id = ?", item.lot_number, i, self.finished_good.id])
            bag.update_attribute(:removing_transaction_id, nil)
          end
        end
      end
    end 
end
