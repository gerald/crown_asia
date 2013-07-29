module DeliverySchedulesHelper
  def time_options
    options = [["", ""]]
    0.upto(23){|i| options << ["#{i}:00", "#{i}:00"]}
    options
  end
end
