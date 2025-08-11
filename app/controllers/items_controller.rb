class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  # before_action :authenticate_user!, except: %i[index show]
  before_action :restrict_to_owner, only: %i[new create edit update destroy]
  # before_action only: %i[new create] { authorize Item }
  # before_action only: %i[edit update destroy] { authorize @item }
  before_action :authorize_item, except: %i[index show]

  def index
    @items = Item.all
  end

  def show
    @variants = @item.item_variants # Load variants for display
  end

  def new
    # @item = Item.new
    # @item.item_variants.build # Initialize one variant for the form
    # @categories = Category.all
    @item = Item.new(category_id: params[:category_id])
    @categories = Category.all.order(:name).map { |c| ["#{'-- ' if c.parent_id}#{c.name}", c.id] }
    authorize @item
  end

  def create
    @item = Item.new(item_params.except(:photo)) # Exclude photo from mass assignment
    authorize @item
    if item_params[:photo].present?
      uploaded_image = Cloudinary::Uploader.upload(item_params[:photo])
      @item.photo = uploaded_image["public_id"]
    end
    if @item.save
      redirect_to @item, notice: "Item created successfully."
    else
      @categories = Category.all.order(:name).map { |c| ["#{'-- ' if c.parent_id}#{c.name}", c.id] }
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.all.order(:name).map { |c| ["#{'-- ' if c.parent_id}#{c.name}", c.id] }
    authorize @item
  end

  def update
    authorize @item
    if item_params[:photo].present?
      uploaded_image = Cloudinary::Uploader.upload(item_params[:photo])
      params[:item][:photo] = uploaded_image["public_id"]
    end
    if @item.update(item_params.except(:photo))
      redirect_to @item, notice: "Item updated successfully."
    else
      @categories = Category.all.order(:name).map { |c| ["#{'-- ' if c.parent_id}#{c.name}", c.id] }
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @item
    @item.destroy
    redirect_to root_path, notice: "Item deleted successfully."
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def authorize_item
    authorize @item || Item
  end

  # def restrict_to_owner
  #   redirect_to root_path, alert: "Only owners can perform this action." unless current_user&.role == 1
  # end

  def item_params
    params.require(:item).permit(
      :name, :price, :stock, :fit_type, :category_id, :photo,
      item_variants_attributes: %i[id size color stock _destroy]
    )
  end
end
