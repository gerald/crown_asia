class Position < ActiveRecord::Base
  validates :name, :presence => true
end
