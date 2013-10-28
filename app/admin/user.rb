ActiveAdmin.register User do

  form do |f|
    f.inputs 'Details' do
      f.input :first_name
      f.input :last_name
      f.input :employee_id
    end
  end

  show do
    attributes_table do
      row :id
      row :employee_id
      row :first_name
      row :last_name
    end

    table_for user.assets do
      column :serial_number
      column :bar_code
      column :asset_type
    end
  end
end
