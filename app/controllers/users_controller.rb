class UsersController < ApplicationController
  def index
    render :show
  end

  def search
    redirect_to user_path(params[:id])
  end

  def show
    @user = User.by_employee_id(params[:id])

    respond_to do |format|
      format.html { flash.now[:alert] = "Employee with id #{params[:id]} not found" unless @user.present? }
      format.json {
        resp = { user: @user }
        resp['assets'] = @user.owned_assets.map { |asset| "#{asset.name}" } if @user.present?
        render json: resp
      }
    end
  end
end
