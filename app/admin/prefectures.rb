ActiveAdmin.register Prefecture do
  config.sort_order = "id_asc"
  config.clear_action_items!
  actions :index, :show

  index do
    column :id
    column :name
    column :created_at
  end
end
