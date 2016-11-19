class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = current_company.items.paginate(page: params[:page], per_page: 20).where(published: true)
  end

  def new
    @item = current_company.items.new
  end

  def show
  end

  def edit
  end

  def create
    @item = current_company.items.new(item_params)
    @item.published = true

    if @item.save
      flash[:notice] = 'Item was successfully created.'
      redirect_to new_item_path
    else
      flash.now[:errors] = @item.errors.full_messages
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
    flash[:success] = 'Item successfully Deleted.'
    redirect_to items_url
  end

  def search
    @items = current_company.items.all.where('name ILIKE ?', "%#{params[:search][:item_name]}%")
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = current_company.items.find(params[:id])
    @categories = current_company.item_categories || []
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
