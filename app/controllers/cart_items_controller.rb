# app/controllers/cart_items_controller.rb
class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart
  before_action :set_cart_item, only: %i[update destroy]
  before_action :authorize_cart

  def create
    @cart_item = @cart.cart_items.find_or_initialize_by(item_variant_id: cart_item_params[:item_variant_id])
    @cart_item.quantity += cart_item_params[:quantity].to_i
    if @cart_item.save
      redirect_to cart_path, notice: "Item added to cart."
    else
      redirect_to items_path, alert: "Failed to add item to cart."
    end
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to cart_path, notice: "Cart item updated."
    else
      redirect_to cart_path, alert: "Failed to update cart item."
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_path, notice: "Item removed from cart."
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find(params[:id])
  end

  def authorize_cart
    authorize @cart
  end

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :item_variant_id, :quantity)
  end
end
