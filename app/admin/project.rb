ActiveAdmin.register Project do
  permit_params :name, :email, :location_id

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :location
    end

    table_for project.assets do
      column :serial_number
      column :bar_code
      column :asset_type
    end
  end
end
