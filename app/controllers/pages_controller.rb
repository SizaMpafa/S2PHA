class PagesController < ApplicationController
  def home
    @categories = Category.where(parent_id: nil).includes(:subcategories)

    if params[:category_id].present? && params[:category_id] != "all"
      begin
        @selected_category = Category.find(params[:category_id])
        category_ids = [@selected_category.id] + @selected_category.subcategories.pluck(:id)
        @items = Item.where(category_id: category_ids).includes(:category)
      rescue ActiveRecord::RecordNotFound
        @selected_category = nil
        @items = Item.all.includes(:category)
      end
    else
      @selected_category = nil
      @items = Item.all.includes(:category)
    end
  end
end
