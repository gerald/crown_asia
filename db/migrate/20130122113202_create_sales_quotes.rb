class CreateSalesQuotes < ActiveRecord::Migration
  def change
    create_table :sales_quotes do |t|
      t.date :quote_date
      t.timestamps
    end
  end
end
