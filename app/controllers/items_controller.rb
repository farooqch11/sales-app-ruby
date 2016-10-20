class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.paginate(page: params[:page], per_page: 20).where(published: true)
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    @item.published = true

    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to @item
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Item was successfully updated.'
      redirect_to @item
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.published = false
    @item.save

    redirect_to items_url
  end

  def search
    @items = Item.all.where('name ILIKE ?', "%#{params[:search][:item_name]}%")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
    @categories = ItemCategory.all
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:image_url,
                                 :sku,
                                 :name,
                                 :description,
                                 :price,
                                 :stock_amount,
                                 :cost_price,
                                 :item_category_id,
                                 :published)
  end
end
