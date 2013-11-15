class HomeController < ApplicationController
  def index
    @projects = Project.all
  end

  def assign
    unless user_not_found || asset_not_found

      if asset.assigned_to?(user)
        asset.unassign!
        flash[:success] = "Unassigned from #{user.name}"
      else
        asset.assign!(user)
        flash[:success] = "Assigned to #{user.name}"
      end

    end
    redirect_to :action => :index
  end

  private
  def asset_not_found
    unless asset
      flash[:alert] = 'Asset not found'
      true
    end
  end

  def user_not_found
    unless user
      flash[:alert] = 'User not found'
      true
    end
  end

  def user
    User.by_employee_id(params[:employee_id])
  end

  def asset
    @asset ||= Asset.by_bar_code(params[:asset_bar_code])
  end
end
