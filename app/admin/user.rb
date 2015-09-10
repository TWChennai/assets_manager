ActiveAdmin.register User do
  menu parent: 'People', priority: 1
  permit_params :name, :employee_id, :admin

  filter :name, as: :select, multiple: true, input_html: { class: 'selectize' }
  # TODO: Can we convert this to use employee name?
  filter :employee_id, :label => 'Employee ID', as: :select, multiple: true, input_html: { class: 'selectize' }

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :employee_id, :label => 'Employee ID'
      f.input :admin
    end
    f.actions
  end

  index do
    column :id
    column :employee_id
    column :name
    column :admin
    actions
  end

  show do
    attributes_table do
      row :id
      row('Employee ID', &:employee_id)
      row :name
      row :admin
    end

    table_for user.owned_assets, :class => 'assets' do
      column do |asset|
        warrenty_link(asset, asset.serial_number)
      end
      column do |asset|
        link_to asset.bar_code, admin_asset_path(asset), :class => asset.status.underscore.gsub(/\s/, '_')
      end
      column :asset_type
    end
  end
end
