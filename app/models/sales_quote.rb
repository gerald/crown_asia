class SalesQuote < ActiveRecord::Base
  has_many :sales_quote_items, :dependent => :destroy
  
  validates :quote_date, :uniqueness => true
  
  accepts_nested_attributes_for :sales_quote_items, :allow_destroy => true, :reject_if => lambda { |a| (a[:finished_good_id].blank? && a[:quote].blank?) }
end
