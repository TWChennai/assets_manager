class HomeController < ApplicationController
  before_filter :load_projects

  def assign
    if user_not_found or asset_not_found
      render :action => :index
      return
    end

    case params[:submit]
    when 'Return'
      unassign
    when 'Assign to Yourself'
      assign_to_me
    when 'Borrow Temporarily'
      assign_to_me(:borrow => true)
    when 'Assign to Project'
      if project_not_found
        render :action => :index
        return
      end
      assign_to_project
    end

    redirect_to :action => :index, :location => params[:location]
  end

  private

  def load_projects
    @projects = Project.all
    @projects = @projects.where(:location => Location.with_name(params[:location])) unless params[:location].blank?
  end

  def unassign
    message = "#{asset.name} returned by #{user.name}"
    current_owner = asset.owner
    message << ". Was used by #{current_owner.name}" if current_owner
    asset.unassign!
    UserMailer.asset_unassigned(asset, current_owner).deliver!
    flash[:success] = message
  end

  def assign_to_me(borrow: false)
    asset.assign!(user, project = nil, borrow = borrow)
    UserMailer.asset_assigned_to_user(asset).deliver!
    message = "#{asset.name} assigned to #{asset.owner.name}"
    flash[:success] = message
  end

  def assign_to_project
    asset.assign!(user, project)
    UserMailer.asset_assigned_to_project(asset).deliver!
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
    User.by_employee_id(params[:employee_id]) unless params[:employee_id].blank?
  end

  def asset
    @asset ||= Asset.by_bar_code(params[:asset_bar_code]) unless params[:asset_bar_code].blank?
  end

  def project
    @project ||= Project.where(:id => params[:project_id]).first unless params[:project_id].blank?
  end
end
