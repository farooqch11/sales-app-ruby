class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  #BreadCrumbs
  add_breadcrumb "LOCATIONS", "#" , options: { title: "LOCATIONS"}


  # GET /locations
  # GET /locations.json
  def index
    @locations = current_company.locations.published.paginate(page: params[:page], per_page: 20)
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    add_breadcrumb  @location.full_address, "#" , options: { title: "NEW LOCATION"}
  end

  # GET /locations/new
  def new
    add_breadcrumb "NEW", new_location_path , options: { title: "NEW LOCATION"}
    @location = current_company.locations.new
    @location.build_address
  end

  # GET /locations/1/edit
  def edit
    add_breadcrumb  @location.full_address, edit_location_path(@location) , options: { title: "EDIT LOCATION"}
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = current_company.locations.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to new_location_path , notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.published = false
    @location.save
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = current_company.locations.published.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit([:name, address_attributes: [:id,:address_1,:city,:state ,:zip,:country, :_destroy]])
      # params.fetch(:location, {})
    end
end
