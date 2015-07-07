class Admin::OrderContentsController < AdminController

	def update
		@order_content = OrderContents.find(params[:order_content_id])
		if @order_content.update(quantity: params[:quantity])
			flash[:success] = "Order quantity updated successfully!"
			redirect_to edit_admin_order_path(@order_content.order_id)
		else
			render :edit
		end
	end

	def destroy
		@order_content = OrderContents.find(params[:id])
		if @order_content.destroy
			flash[:success] = "Order item removed successfully!"
			redirect_to edit_admin_order_path(@order_content.order_id)
		else
			redirect_to session.delete(:return_to)
		end
	end

	def create
		@order_content = OrderContents.new
		@order_content.order_id = params[:order_id]
		@order_content.product_id = params[:product_id]
		@order_content.quantity = params[:quantity]
		if @order_content.save
			flash[:success] = "Order added successfully!"
			redirect_to edit_admin_order_path(params[:order_id])
		else
			render :edit
		end
	end

end
