ActiveAdmin.register Project do
  menu :parent => "EXPERIMENTS", :priority => 4
  scope :all, :default => true
  scope :admin_a do |project|
    project.where(:admin_name => "A")
  end
  scope :admin_b do |project|
    project.where(:admin_name => "B")
  end
  scope :admin_c do |project|
    project.where(:admin_name => "C")
  end
  scope :admin_d do |project|
    project.where(:admin_name => "D")
  end
  
  
  # Configuration for Sidebar Filters
  filter :round, :as => :select
  filter :name
  filter :group, :as => :select
  filter :goal_amount
  filter :start_amount
  filter :funded_amount
  filter :created_at
  
  
  # Configuration for Projects Index Page
  config.sort_order = "id_asc"
  config.per_page = 15

  index do
    selectable_column
    column :id
    column :name, :sortable => :name do |project|
       div :class => "admin-center-column" do 
          project.name
       end
    end
    column :goal_amount, :sortable => :goal_amount do |project|
       div :class => "admin-center-column" do 
          project.goal_amount
       end
    end
    column :start_amount, :sortable => :start_amount do |project|
       div :class => "admin-center-column" do 
          project.start_amount
       end
    end
    column :funded_amount, :sortable => :funded_amount do |project|
       div :class => "admin-center-column" do 
          project.funded_amount
       end
    end
    column :admin_name, :sortable => :admin_name do |project|
       div :class => "admin-center-column" do 
          project.admin_name
       end
    end  
    column :group, :sortable => :group do |project|
       div :class => "admin-center-column" do 
          project.group
       end
    end
    column :created_at
    default_actions
  end
  
  
  # Configuration for Projects Show Page
  show do |user|
    attributes_table do
      row :id
      row :name
      row :goal_amount
      row :start_amount
      row :funded_amount
      row :group
      row :round
      row :admin_name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
  
  
  # Configuration for Projects Edit Page
  form do |f|                         
   f.inputs "New Project" do       
     f.input :round, :as => :select
     f.input :name
     f.input :goal_amount 
     f.input :start_amount
     f.input :funded_amount
     f.input :admin_name 
   end                               
   f.actions                         
  end
  
end
