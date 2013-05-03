class CreateSalesQuoteItems < ActiveRecord::Migration
  def change
    create_table :sales_quote_items do |t|
      t.integer :finished_good_id
      t.integer :sales_quote_id
      t.decimal :quote, :precision => 11, :scale => 2
      t.timestamps
    end
  end
end
