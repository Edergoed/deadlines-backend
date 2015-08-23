class SwapProductWithDeadline < ActiveRecord::Migration
  def change
  	rename_table :products, :deadlines
  end
end
