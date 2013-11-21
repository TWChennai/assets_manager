class HomeController < ApplicationController
  before_filter :load_projects

  def assign
    if user_not_found or asset_not_found
      render :action => :index
      return
    end

    unassign if params[:submit] == 'Return'
    assign_to_me if params[:submit] == 'Take For Yourself'

    if params[:submit] == 'Take For Project'
      if project_not_found
        render :action => :index
        return
      end
      assign_to_project
    end

    redirect_to :action => :index
  end

  private

  def load_projects
    @projects = Project.all
  end

  def unassign
    message = "#{asset.name} returned by #{user.name}"
    message << ". Was used by #{asset.owner.name}" if asset.owner
    asset.unassign!
    flash[:success] = message
  end

  def assign_to_me
    asset.assign!(user, nil)
    message = "#{asset.name} assigned to #{asset.owner.name}"
    flash[:success] = message
  end

  def assign_to_project
    asset.assign!(user, project)
    flash[:success] = "#{asset.name} assigned to #{asset.owner.name}"
  end

  def asset_not_found
    unless asset
      flash.now[:alert] = 'Asset not found'
      true
    end
  end

  def user_not_found
    unless user
      flash.now[:alert] = 'User not found'
      true
    end
  end

  def project_not_found
    unless project
      flash.now[:alert] = 'Please select a project'
      true
    end
  end

  def user
    User.by_employee_id(params[:employee_id])
  end

  def asset
    @asset ||= Asset.by_bar_code(params[:asset_bar_code])
  end

  def project
    @project ||= (params[:project_id] && Project.where(:id => params[:project_id]).first)
  end
end
