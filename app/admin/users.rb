ActiveAdmin.register User do
    menu parent: 'Dashboard', priority: 1
  
    index do
      selectable_column
      id_column
      column :name
      column :email
      column :created_at
      actions
    end
  end  