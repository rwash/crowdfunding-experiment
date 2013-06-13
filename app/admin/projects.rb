ActiveAdmin.register Project do
  # actions :index, :show  
  config.batch_actions = false  
  menu :parent => "USERS", :priority => 2
  scope :all, :default => true
  
  
  # Configuration for Sidebar Filters
  filter :name, :label => "Project Name", :as => :select, :collection => Project.order("name ASC").uniq.pluck(:name)
  filter :goal_amount
  filter :start_amount
  filter :funded_amount
  
  
  # Configuration for Projects Index Page
  config.sort_order = "id_asc"
  config.per_page = 15
  index do
    selectable_column
    column :experiment do |project|
      link_to "Experiment ##{project.round.experiment_id}", admin_experiment_path(project.round.experiment_id)
    end
    column :round_id, :sortable => :round_id do |project|
       div :class => "admin-center-column" do 
          link_to "Round #{project.round.number}", admin_round_path(project.round)
       end
    end
    column "Project Name", :sortable => :name do |project|
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
    default_actions
  end
  
  
  # Configuration for Projects Show Page
  show do |project|
    attributes_table do
      row :experiment do |project|
        link_to "Experiment ##{project.round.experiment_id}", admin_experiment_path(project.round.experiment_id)
      end
      row :round do |project|
        link_to "Round #{project.round.number}", admin_round_path(project.round_id)
      end
      row :name
      row :goal_amount
      row :start_amount
      row :funded_amount
    end
    active_admin_comments
  end
  
end
