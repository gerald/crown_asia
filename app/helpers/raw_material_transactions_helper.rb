module RawMaterialTransactionsHelper

  def lot_number_options(raw_material)
    lot_numbers = RawMaterialTransactionItem.all(:select => "lot_number").collect{|r| r.lot_number}.uniq!
    lot_numbers.collect{|l| ["#{l} - #{raw_material.quantity_on_hand(l)} available", l]}
  end

end
