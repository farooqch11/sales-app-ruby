class ItemCategoriesController < ApplicationController
  before_action :set_item_category, only: [:show, :update, :destroy]

  def index
    @item_categories = current_company.item_categories.paginate(page: params[:page], per_page: 20)
    @item_category = current_company.item_categories.new
  end

  def show
  end

  def new
    @item_category = current_company.item_categories.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    @item_category = current_company.item_categories.new(item_category_params)

    respond_to do |format|
      if @item_category.save
        format.html{ flash[:success] = 'Item category was successfully created.'
        redirect_to item_categories_url }
        format.js{  flash.now[:success] = "Item category was successfully created."}

      else
        format.html{
        flash.now[:errors] = @item_category.errors.full_messages
        render action: 'new' }
        format.js{  flash.now[:errors] = @item_category.errors.full_messages }
      end
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
