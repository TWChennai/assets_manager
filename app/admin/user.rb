ActiveAdmin.register User do

  filter :name
  filter :employee_id, :label => 'Employee ID'

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
    default_actions
  end

  show do
    attributes_table do
      row :id
      row('Employee ID') { user.employee_id }
      row :name
      row :admin
    end

    table_for user.owned_assets do
      column :serial_number
      column :bar_code
      column :asset_type
    end
  end
end
