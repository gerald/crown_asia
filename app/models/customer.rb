class Customer < ActiveRecord::Base

  validates :name, :presence => true

  has_many :sent_raw_material_transactions, :as => :sender, :class_name => "RawMaterialTransaction"
  has_many :sent_finished_good_transactions, :as => :sender, :class_name => "FinishedGoodTransaction"
  has_many :issued_finished_good_transactions, :as => :issued_to, :class_name => "FinishedGoodTransaction"
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
  
  before_destroy :check_associations
  
  scope :active_customers, :conditions => {:active => true}, :order => "name"
  scope :fg_customers, :conditions => {:active => true, :applicable_to_fg => true}, :order => "name"
  
  protected
  
    def check_associations
      if self.sent_raw_material_transactions.count > 0 || self.sent_finished_good_transactions.count > 0 || self.issued_finished_good_transactions.count > 0
        errors.add(:base, "Cannot delete the customer because it is currently associated with a record.")
      end
      errors.blank?
    end
  
end
