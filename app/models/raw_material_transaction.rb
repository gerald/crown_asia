class RawMaterialTransaction < ActiveRecord::Base

  belongs_to :raw_material
  belongs_to :issued_department, :class_name => "Department"
  belongs_to :sender, :polymorphic => true
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  has_many :raw_material_transaction_items, :dependent => :destroy
  
  accepts_nested_attributes_for :raw_material_transaction_items, :allow_destroy => true, :reject_if => lambda { |a| a[:lot_number].blank? && a[:quantity].blank? }
  
  validates :transaction_date, :presence => true
  validates :reference_type, :reference_number, :po_number, :sender, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  validates :reference_number, :po_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "add" }
  
  validates :mirs_number, :issued_department, :presence => true, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  validates :mirs_number, :format => {:with => /[0-9]+/}, :if => Proc.new { |transaction| transaction.transaction_type == "sub" }
  
  validate :raw_material_quantity
  
  acts_as_paranoid
  
  acts_as_audited :except => [:deleted_at]
  
  def raw_material_quantity
    return if self.transaction_type != "sub"
    self.raw_material_transaction_items.each do |item|
      if item.quantity && item.quantity > self.raw_material.quantity_on_hand(item.lot_number)
        errors.add(:base, "Transaction item quantity cannot be more than the remaining quantity of the raw material")
        return
      end
    end
  end
end
