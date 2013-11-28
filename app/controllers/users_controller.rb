class UsersController < ApplicationController
  def index
    render :show
  end

  def search
    redirect_to user_path(params[:id])
  end

  def show
    @user = User.by_employee_id(params[:id])
    flash.now[:alert] = "Employee with id #{params[:id]} not found" unless @user.present?
  end
end
