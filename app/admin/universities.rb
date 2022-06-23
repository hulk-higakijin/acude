ActiveAdmin.register University do
  config.sort_order = 'id_asc'
  config.clear_action_items!
  actions :index, :show

  index do
    %i[id name prefecture active updated_at].each do |i|
      column i
    end
    actions
  end

  show do
    attributes_table do
      %i[id prefecture name faculties note introduction].each do |i|
        row i
      end
      row :url do |e|
        link_to e.url, e.url, target: '_blank'
      end
    end
  end

  controller do
    def scoped_collection
      super.includes :prefecture
    end
  end
end
