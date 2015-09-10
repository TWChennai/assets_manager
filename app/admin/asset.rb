ActiveAdmin.register Asset do
  permit_params :bar_code, :serial_number, :asset_type_id, :location_id, :brand_id, :status, :user_id, :project_id, :description

  controller do
    def scoped_collection
      super.includes(:location, :brand, :project, :user)
    end
  end

  form do |f|
    f.inputs 'Details' do
      f.input :bar_code
      f.input :serial_number
      f.input :asset_type
      f.input :location
      f.input :brand
      f.input :status, :as => :select, :collection => Asset::VALID_STATUSES
      f.input :user, as: :select, input_html: { class: 'selectize' }
      f.input :project
      f.input :description
    end

    f.actions
  end

  index do
    column :bar_code
    column :asset_type
    column :status
    column :location
    column :brand
    column :project
    column :user
    column :serial_number

    actions
  end

  action_item :only => :show do
    link_to 'Unassign', unassign_admin_asset_path(params[:id]), :method => :put
  end

  action_item :only => :show do
    link_to 'Add an Asset', new_admin_asset_path
  end

  action_item :only => :show, :if => proc{ asset.borrowed? } do
    link_to 'Assign Permanently', assign_permanent_admin_asset_path(params[:id]), :method => :put
  end

  member_action :unassign, :method => :put do
    asset = Asset.find(params[:id])
    asset.unassign!
    redirect_to({ :action => :show }, { :notice => 'Unassigned!' })
  end

  member_action :assign_permanent, :method => :put do
    asset = Asset.find(params[:id])
    asset.assign_permanent!
    redirect_to({ :action => :show }, { :notice => 'Assigned Permanently' })
  end
end
