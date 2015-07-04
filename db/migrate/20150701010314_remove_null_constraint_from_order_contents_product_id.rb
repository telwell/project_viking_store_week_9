class RemoveNullConstraintFromOrderContentsProductId < ActiveRecord::Migration
  def change
  	change_column :order_contents, :product_id, :integer, :null => true
  end
end
