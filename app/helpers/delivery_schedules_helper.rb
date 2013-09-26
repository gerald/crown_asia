module DeliverySchedulesHelper
  def time_options
    options = [["", ""]]
    0.upto(23){|i| options << ["#{i}:00", "2000-01-01 #{i}:00:00 UTC"]}
    options
  end
end
