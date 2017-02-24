class ItemsController < ApplicationController

  load_and_authorize_resource

  add_breadcrumb "ITEMS", "" , options: { title: "ITEMS"}
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @search = current_company.items.search(params[:q])
    @items = @search.result.includes(:item_category , :location).order(created_at: :desc).paginate(page: params[:page], per_page: 20).published
  end

  def new
    add_breadcrumb "NEW", new_item_path , options: { title: "NEW ITEM"}
    @item = current_company.items.new
  end

  def show
  end

  def edit
    add_breadcrumb "EDIT", edit_item_path(@item) , options: { title: "EDIT ITEM"}
  end

  def create
    @item = current_company.items.new(item_params)
    @item.published = true
    respond_to do |format|
      if @item.save
        format.html{ redirect_to items_path , notice: 'Item was successfully created.'}
      else
        format.html{
        flash[:errors] = @item.errors.full_messages
        render action: 'new'
        }
      end
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

  def low_stock
    @search = current_company.low_stock_items.search(params[:q])
    @items = @search.result.includes(:item_category , :location).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def search
    @items = current_company.items.all.where('name LIKE ?', "%#{params[:search][:item_name]}%")
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
                                 :photo,
                                 :barcode,
                                 :shelf,
                                 :tax,
                                 :location_id,
                                 :description,
                                 :price,
                                 :stock_amount,
                                 :cost_price,
                                 :item_category_id,
                                 :published)
  end
end
