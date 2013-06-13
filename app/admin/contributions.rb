ActiveAdmin.register Contribution do    
  # actions :index, :show
  config.batch_actions = false  
  menu :parent => "USERS", :priority => 3
  scope :all, :default => true


  # Configuration for Sidebar Filters
  filter :project_name, :label => "Project Name", :as => :select, :collection => Project.order("name ASC").uniq.pluck(:name)
  filter :amount
  
    
  # Configuration for Contributions Index Page
  config.sort_order = "id_asc"  
  config.per_page = 15
  index do
    column "Experiment", :sortable => :experiment_id do |contribution|
      link_to "Experiment ##{contribution.user.experiment_id}", admin_experiment_path(contribution.user.experiment_id)
    end
    column "Round", :sortable => :round_id do |contribution|
      link_to "Round #{contribution.project.round.number}", admin_round_path(contribution.project.round_id)
    end
    column "Group", :sortable => :group_id do |contribution|
      link_to "Group #{contribution.group.name}", admin_group_path(contribution.group_id)
    end
    column :user_id, :sortable => :user_id do |contribution|
      link_to "User #{contribution.user_id}", admin_user_path(contribution.user_id)
    end
    column "Project Name", :sortable => :project_id do |contribution|
      div :class => "admin-center-column" do   
        contribution.project.name
      end
    end
    column :amount do |contribution|
       div :class => "admin-center-column" do 
          contribution.amount
       end
    end
    default_actions
  end  


  # Configuration for Contributions Show Page
  show do |contribution|
    attributes_table do
      row "Experiment" do |contribution|
        link_to "Experiment ##{contribution.user.experiment_id}", admin_experiment_path(contribution.user.experiment_id)
      end   
      row "Round" do |contribution|
        link_to "Round #{contribution.project.round.number}", admin_round_path(contribution.project.round_id)
      end
      row "Group" do |contribution|
        link_to "Group #{contribution.group.name}", admin_group_path(contribution.group_id)
      end   
      row "User" do |contribution|
        link_to "User #{contribution.user_id}", admin_user_path(contribution.user_id)
      end
      row "Project Name" do |contribution|
        contribution.project.name
      end
      row :amount
      row :created_at
    end
    active_admin_comments
  end  
  
end