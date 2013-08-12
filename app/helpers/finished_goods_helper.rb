module FinishedGoodsHelper
  def delivery_schedules_option(finished_good)
    ds = DeliverySchedule.includes({:delivery_schedule_items => :finished_goods})
    ds = ds.where("finished_goods.id = ? AND delivery_date >= ?", finished_good.id, Date.current)
    ds
  end
end
