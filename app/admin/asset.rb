ActiveAdmin.register Asset do
  form do |f|
    f.inputs 'Details' do
      f.input :bar_code
      f.input :serial_number
      f.input :asset_type
      f.input :brand
      f.input :status, :as => :select, :collection => Asset::VALID_STATUSES
      f.input :user
      f.input :description
    end

    f.actions
  end

  index do
    column :bar_code
    column :asset_type
    column :status
    column :brand
    column :project
    column :user do |a|
      a.user.try &:name
    end
    column :serial_number

    default_actions
  end

  action_item :only => :show do
    link_to 'Add an Asset', new_admin_asset_path
    link_to 'Unassign', unassign_admin_asset_path(params[:id]), :method => :put
  end

  member_action :unassign, :method => :put do
    user = User.find(params[:id])
    user.lock!
    redirect_to({ :action => :show }, { :notice => 'Unassigned!' })
  end


end
