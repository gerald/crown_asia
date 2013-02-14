module RawMaterialTransactionsHelper

  def lot_number_options(raw_material)
    lot_numbers = RawMaterialTransactionItem.select("DISTINCT(lot_number)").includes(:raw_material_transaction).group("lot_number").where("raw_material_transactions.raw_material_id = ?", raw_material.id).collect{|r| r.lot_number}
    lot_numbers = lot_numbers.select{|l| raw_material.quantity_on_hand(l) > 0}
    lot_numbers.collect{|l| ["#{l} - #{raw_material.quantity_on_hand(l)} available", l]}
  end

end
