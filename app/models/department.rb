class Department < ActiveRecord::Base

  validates_presence_of :name, :code
  
  has_many :raw_material_transactions, :foreign_key => "issued_department_id"
  has_many :sent_raw_material_transactions, :as => :sender

end
