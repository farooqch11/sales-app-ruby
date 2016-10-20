class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def show
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      flash[:notice] = 'Contact was successfully created.'
      redirect_to @contact
    else
      render action: 'new'
    end
  end

  def update
    if @contact.update(contact_params)
      flash[:notice] = 'Contact was successfully updated.'
      redirect_to @contact
    else
      render action: 'edit'
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contact
    @contact = Contact.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contact_params
    params[:contact]
  end
end
