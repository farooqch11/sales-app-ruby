class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  def index
    @line_items = LineItem.all
  end

  def new
    @line_item = LineItem.new
  end

  def show
  end

  def edit
  end

  def create
    @line_item = LineItem.new(line_item_params)

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
    @line_item = LineItem.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def line_item_params
    params.require(:line_item).permit(:item_id, :quantity, :price, :sale_id)
  end
end
