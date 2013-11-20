ActiveAdmin.register User do

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :employee_id, :label => 'Employee ID'
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :employee_id
      row :name
    end

    table_for user.assets do
      column :serial_number
      column :bar_code
      column :asset_type
    end
  end
end
