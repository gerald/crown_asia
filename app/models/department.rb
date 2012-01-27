class Department < ActiveRecord::Base

  validates :name, :code, :presence => true
  
  has_many :raw_material_transactions, :foreign_key => "issued_department_id"
  
  has_many :sent_raw_material_transactions, :as => :sender
  has_many :sent_finished_good_transactions, :as => :sender
  
  belongs_to :creator, :class_name => "User"
  belongs_to :updater, :class_name => "User"
end
