class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]
  before_action :find_sale , only: [:set_line_item ,:create , :new]

  def index
    @line_items = current_company.line_items || []
  end

  def new
    @line_item = @sale.line_items.new
  end

  def show
  end

  def edit
  end

  def create
    @line_item = @sale.line_items.new(line_item_params)

    if @line_item.save
      flash[:notice] = 'Line item was successfully created.'
      redirect_to @line_item
    else
      render action: 'new'
    end
  end

  def update
    if @line_item.update(line_item_params)
      flash[:notice] = 'Line item was successfully updated.'
      redirect_to @line_item
    else
      render action: 'edit'
    end
  end

  def destroy
    @line_item.destroy
    redirect_to line_items_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = @sale.line_items.find(params[:id]) || []
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def line_item_params
    params.require(:line_item).permit(:item_id, :quantity, :price)
  end
   def find_sale
     @sale = current_company.sales.find_by_id(params[:sale_id]) || []
   end
end
