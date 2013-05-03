class AddSalesQuoteToFinishedGoods < ActiveRecord::Migration
  def change
    add_column :finished_goods, :sales_quote, :boolean, :default => false
  end
end
