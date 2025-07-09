# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart
  before_action :authorize_cart

  def show
    @cart_items = @cart.cart_items.includes(:item, :item_variant)
  end

  def update
    if @cart.update(cart_params)
      redirect_to cart_path, notice: "Cart updated successfully."
    else
      @cart_items = @cart.cart_items.includes(:item, :item_variant)
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def authorize_cart
    authorize @cart
  end

  def cart_params
    params.require(:cart).permit(cart_items_attributes: %i[id quantity])
  end
end
