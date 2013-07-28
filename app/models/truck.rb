class Truck < ActiveRecord::Base
  validates :plate_number, :presence => true, :uniqueness => true
  validates :capacity, :presence => true, :numericality => true
  validates :plate_number, :format => {:with => /[A-Z]{3}[0-9]{3}/}
  
  before_validation :format_plate_numbers
  
  protected
  
    def format_plate_numbers
      self.plate_number = self.plate_number.upcase.gsub(" ", "")
    end
end
