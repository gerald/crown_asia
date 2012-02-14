class FinishedGoodTransaction < ActiveRecord::Base
  belongs_to :finished_good
  belongs_to :sender, :polymorphic => true
  belongs_to :issued_to, :polymorphic => true
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  has_many :removed_bags, :foreign_key => "removing_transaction_id", :class_name => "Bag", :dependent => :nullify
  
  has_many :finished_good_transaction_items
  
  accepts_nested_attributes_for :finished_good_transaction_items, :allow_destroy => true, :reject_if => lambda { |a| (a[:lot_number].blank? && a[:start_bag_number].blank? && a[:end_bag_number].blank? && a[:quantity].blank?) }
  
  validates :transaction_date, :presence => true
  
  validates :reference_type, :reference_number, :sender, :quantity_per_bag, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :quantity_per_bag, :numericality => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :reference_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  
  validates :issue_type, :issued_to, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  validates :dr_number, :si_number, :presence => true, :if => Proc.new { |transaction| transaction.issue_type == "Customer" && transaction.transaction_type == "sub" }
  validates :mirs_number, :presence => true, :if => Proc.new { |transaction| transaction.issue_type == "Internal" && transaction.transaction_type == "sub" }
  validates :dr_number, :si_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.issue_type == "Customer" && transaction.transaction_type == "sub" }
  validates :mirs_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.issue_type == "Internal" && transaction.transaction_type == "sub" }
  
  after_create :create_bags
  
  acts_as_paranoid
  
  acts_as_audited

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
      self.finished_good_transaction_items.each do |item|
        if item.underpack
          Bag.create(:bag_number => 0, :finished_good => self.finished_good, :finished_good_transaction_item => item, :quantity => item.quantity)
        else
          item.start_bag_number.upto(item.end_bag_number) do |i|
            Bag.create(:bag_number => i, :finished_good => self.finished_good, :finished_good_transaction_item => item, :quantity => self.quantity_per_bag)
          end
        end
      end
    end
end
