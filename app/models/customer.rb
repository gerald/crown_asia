class Customer < ActiveRecord::Base

  validates :name, :presence => true

  has_many :sent_raw_material_transactions, :as => :sender
  has_many :sent_finished_good_transactions, :as => :sender
end
