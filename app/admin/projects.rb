ActiveAdmin.register Project do
  actions :index, :show  
  config.batch_actions = false  
  menu :parent => "USERS", :priority => 3
  scope :all, :default => true
  scope :type_a do |project|
    project.where(:admin_name => "A")
  end
  scope :type_b do |project|
    project.where(:admin_name => "B")
  end
  scope :type_c do |project|
    project.where(:admin_name => "C")
  end
  scope :type_d do |project|
    project.where(:admin_name => "D")
  end
  
  
  # Configuration for Sidebar Filters
  filter :round_group_name, :label => "Group", :as => :select, :collection => Group.uniq.pluck(:name)
  filter :round_number, :label => "Round", :as => :select, :collection => Round.uniq.pluck(:number)
  filter :admin_name, :label => "Project Type", :as => :select, :collection => Project.order("admin_name ASC").uniq.pluck(:admin_name)
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
      link_to "Experiment ##{project.round.group.experiment_id}", admin_experiment_path(project.round.group.experiment_id)
    end
    column "Group" do |project|
      link_to "Group #{project.round.group.name}", admin_group_path(project.round.group_id)
    end
    column :round_id, :sortable => :round_id do |project|
       div :class => "admin-center-column" do 
          link_to "Round #{project.round.number}", admin_round_path(project.round)
       end
    end
    column "Project Type", :sortable => :admin_name do |project|
       div :class => "admin-center-column" do 
          "Type #{project.admin_name}"
       end
    end
    column "Project Name", :sortable => :name do |project|
       div :class => "admin-center-column" do 
          project.name
       end
    end
    column :value, :sortable => :value do |project|
       div :class => "admin-center-column" do 
          project.value
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
        link_to "Experiment ##{project.round.group.experiment_id}", admin_experiment_path(project.round.group.experiment_id)
      end
      row :group do |project|
        link_to "Group #{project.round.group.name}", admin_group_path(project.round.group_id)        
      end
      row :round do |project|
        link_to "Round #{project.round_id}", admin_round_path(project.round_id)
      end
      row "Project Type" do |project|
        "Type #{project.admin_name}"
      end
      row :name
      row :goal_amount
      row :start_amount
      row :funded_amount
    end
    active_admin_comments
  end
  
end
