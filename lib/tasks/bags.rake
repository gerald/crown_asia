namespace :bags do
  desc 'Populate lot numbers'
  task :populate_lot_numbers => :environment do
    Bag.all.each do |bag|
      bag.update_attribute(:lot_number, bag.finished_good_transaction_item.lot_number)
    end
  end
  
  desc 'Update underpack bags with missing lot numbers'
  task :populate_missing_underpack_lot_numbers => :environment do
    Bag.all(:conditions => "bag_number = 0 AND (lot_number = '0' OR lot_number IS NULL)").each_with_index do |bag, index|
      bag.update_attribute(:lot_number, "#{index + 1}")
    end
  end
  
  
end
