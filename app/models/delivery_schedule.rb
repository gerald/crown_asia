class DeliverySchedule < ActiveRecord::Base
  has_many :delivery_schedule_items
  
  belongs_to :truck
  belongs_to :driver, :class_name => "Personnel"
  belongs_to :delivery_helper_1, :class_name => "Personnel"
  belongs_to :delivery_helper_2, :class_name => "Personnel"
  
  accepts_nested_attributes_for :delivery_schedule_items, :allow_destroy => true, :reject_if => lambda { |a| a[:customer_id].blank? && a[:quantity].blank? && a[:finished_good_id].blank? }
  
  validates :delivery_date, :delivery_time, :truck, :driver, :presence => true
  
  validate :cancel_reason_exists_for_canceled_schedules
  
  before_create :set_control_number
  
  def next_control_number
    year = self.delivery_date.strftime("%y")
    last_delivery = DeliverySchedule.where("delivery_date >= ? AND delivery_date < ?", Date.parse("1/1/#{self.delivery_date.year}"), Date.parse("1/1/#{self.delivery_date.year + 1}")).last
    number = last_delivery && last_delivery.control_number ? last_delivery.control_number.split("-")[1].to_i + 1 : 1
    number = "%04d" % number
    "#{year}-#{number}"
  end
  
  def delivery_date_time
    DateTime.new(self.delivery_date.year, self.delivery_date.month, self.delivery_date.day, self.delivery_time.hour, self.delivery_time.min)
  end
  
  protected
  
    def set_control_number
      self.control_number = self.next_control_number
    end
    
    def cancel_reason_exists_for_canceled_schedules
      if self.canceled && self.cancel_reason.blank?
        self.errors.add(:base, "Reason is required when canceling a delivery schedule")
      end
    end
end
