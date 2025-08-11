class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_category, only: %i[show edit update destroy]
  before_action :authorize_category, except: %i[index show]

  def index
    @categories = Category.where(parent_id: nil).includes(:subcategories)
  end

  def show
    @items = @category.items.includes(:item_variants)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: "Category created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Category updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy!
    redirect_to categories_path, notice: "Category deleted successfully."
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to categories_path, alert: "Cannot delete category with items or subcategories."
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def authorize_category
    authorize(@category || Category)
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
