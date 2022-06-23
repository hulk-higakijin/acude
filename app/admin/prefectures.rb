ActiveAdmin.register Prefecture do
  config.sort_order = 'id_asc'
  config.clear_action_items!
  actions :index, :show

  index do
    %i[id name created_at].each do |i|
      column i
    end
  end
end
