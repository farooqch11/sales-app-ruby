class ItemCategoriesController < ApplicationController
  before_action :set_item_category, only: [:show,:new, :update, :destroy]

  def index
    @item_categories = current_company.item_categories.paginate(page: params[:page], per_page: 20)
    @item_category = current_company.item_categories.new
  end

  def show
  end

  def new
  end

  def create
    @item_category = current_company.item_categories.new(item_category_params)

    if @item_category.save
      flash[:success] = 'Item category was successfully created.'
      redirect_to item_categories_url
    else
      flash.now[:errors] = @item_category.errors.full_messages
      render action: 'new'
    end
  end

  def update
    if @item_category.update(item_category_params)
      flash[:success] = 'Item category was successfully updated.'
      redirect_to @item_category
    else
      flash[:errors] = @item_category.errors.full_messages
      render action: 'show'
    end
  end

  def destroy
    name = @item_category.name
    if @item_category.destroy
      flash[:success] = 'Item category successfully deleted.'
    end
    redirect_to item_categories_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item_category
    @item_category = current_company.item_categories.friendly.find(params[:id]) || []
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_category_params
    params.require(:item_category).permit(:name, :description)
  end
end
