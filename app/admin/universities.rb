ActiveAdmin.register University do
  config.sort_order = "id_asc"
  config.clear_action_items!
  actions :index, :show

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :introduction, :prefecture_id, :url, :note, :active
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :introduction, :prefecture_id, :url, :note, :active]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  controller do
    def scoped_collection
      super.includes :prefecture
    end
  end
end
