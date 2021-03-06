class PasswordsController < ApplicationController
  def update
    if current_user.valid_password?(params[:current_password][:password])
      @user = current_user
      if @user.update_attributes(password: params[:password][:password],password_confirmation: params[:password][:password_confirmation])
        flash[:success] = "Your password has been successfully changed, Please login again."
        return redirect_to new_user_session_path
      else
        flash[:errors] = @user.errors.full_messages
        return redirect_to :back
      end
    else
      flash[:error] = "Current password does not match"
      return redirect_to :back
    end
    # respond_to do |format|
    #   format.js { ajax_refresh }
    # end
  end
  private

  def ajax_refresh
    render 'template/ajax_reload'
  end

end
