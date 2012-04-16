namespace :bags do
  desc 'Populate lot numbers'
  task :populate_lot_numbers => :environment do
    Bag.all.each do |bag|
      bag.update_attribute(:lot_number, bag.finished_good_transaction_item.lot_number)
    end
  end
end
