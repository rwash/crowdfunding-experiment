ActiveAdmin.register ActiveAdmin::Comment do
  menu :parent => "ADMIN", :priority => 2
  scope :all, :default => true
  
  
  # Configuration for Sidebar Filters
  filter :resource_type
  
  
  # Configuration for Comments Index Page
  config.sort_order = "id_asc"
  config.per_page = 15
  index do 
    selectable_column
    column :author 
    column :resource
    column :resource_type
    default_actions
  end   
  
  
  # Configuration for Comments Show Page
  show do |comment|
    attributes_table do  
      row :author
      row :resource
      row :resource_type
      row :body
      row :created_at
    end
    active_admin_comments
  end
  
end
