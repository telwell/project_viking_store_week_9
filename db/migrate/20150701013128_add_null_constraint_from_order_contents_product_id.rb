class AddNullConstraintFromOrderContentsProductId < ActiveRecord::Migration
  def change
  	change_column :order_contents, :product_id, :integer, :null => false
  end
end
