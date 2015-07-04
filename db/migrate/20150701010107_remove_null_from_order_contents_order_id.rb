class RemoveNullFromOrderContentsOrderId < ActiveRecord::Migration
  def change
  	change_column :order_contents, :order_id, :integer, :null => true
  end
end
