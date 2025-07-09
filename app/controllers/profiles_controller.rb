class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :authorize_user

  def show
    @orders = @user.orders
  end

  private

  def set_user
    @user = current_user
  end

  def authorize_user
    authorize @user
  end
end
