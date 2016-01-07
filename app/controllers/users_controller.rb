class UsersController < ApplicationController
  def index
    render :show
  end

  def search
    redirect_to user_path(params[:id])
  end

  def show
    @user = User.by_employee_id(params[:id])
    if request.format.symbol == :json
      resp={:user => @user }
      resp['assets']=@user.owned_assets.map{|asset| "#{asset.name.to_s}"}
      render :json => resp
    end
    flash.now[:alert] = "Employee with id #{params[:id]} not found" unless @user.present?
  end
end
