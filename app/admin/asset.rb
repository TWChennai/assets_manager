ActiveAdmin.register Asset do
  form do |f|
    f.inputs 'Details' do
      f.input :bar_code
      f.input :serial_number
      f.input :asset_type
      f.input :status, :as => :select, :collection => Asset::VALID_STATUSES
      f.input :description
    end

    f.actions
  end

  index do
    column :bar_code
    column :asset_type
    column :status
    column :user
    column :serial_number

    default_actions
  end

end
