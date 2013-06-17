ActiveAdmin.register Project do
  # actions :index, :show  
  config.batch_actions = false  
  menu :parent => "USERS", :priority => 2
  scope :all, :default => true
  
  
  # Configuration for Sidebar Filters
  filter :name, :label => "Project Name", :as => :select, :collection => Project.order("name ASC").uniq.pluck(:name)
  filter :goal_amount
  filter :start_amount
  filter :total_contributions
  
  
  # Configuration for Projects Index Page
  config.sort_order = "id_asc"
  config.per_page = 15
  index do
    selectable_column
    column :experiment do |project|
      link_to "Experiment ##{project.group.round.experiment_id}", admin_experiment_path(project.group.round.experiment_id)
    end
    column :round, :sortable => :round_id do |project|
       div :class => "admin-center-column" do 
          link_to "Round #{project.group.round.number}", admin_round_path(project.group.round)
       end
    end                               
    column :group, :sortable => :group do |project|
       div :class => "admin-center-column" do 
          link_to "Group #{project.group.name}", admin_group_path(project.group_id)
       end
    end    
    column :user, :sortable => :user do |project|
       div :class => "admin-center-column" do 
          link_to "User #{project.user_id}", admin_user_path(project.user_id)           
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
    column :popularity, :sortable => :popularity do |project|
       div :class => "admin-center-column" do 
          project.popularity
       end
    end
    default_actions
  end
  
  
  # Configuration for Projects Show Page
  show do |project|
    attributes_table do
      row :experiment do |project|
        link_to "Experiment ##{project.group.round.experiment_id}", admin_experiment_path(project.group.round.experiment_id)
      end
      row :round do |project|
        link_to "Round #{project.group.round.number}", admin_round_path(project.group.round_id)
      end
      row :group do |project|
        link_to "Group #{project.group.name}", admin_group_path(project.group_id)
      end  
      row :user do |project|
        link_to "User #{project.user_id}", admin_user_path(project.user_id) 
      end
      row :name  
      row :value
      row :popularity
      row :goal_amount
      row :standard_return_amount
      row :special_return_amount 
      row :total_contributions
      row :number_donors
      row :funded do |project|
        project.funded.yesno
      end  
      row :creator_earnings
      row :special_user_1 do |project|
        link_to "User #{project.special_user_1}", admin_user_path(project.special_user_1)       
      end   
      row :special_user_2 do |project|
        link_to "User #{project.special_user_2}", admin_user_path(project.special_user_2)       
      end    
      row "Contributions" do
        table_for(project.contributions) do
          column :id do |contribution|
            link_to "Contribution #{contribution.id}", admin_contribution_path(contribution.id)
          end
          column :amount
        end
      end
    end
    active_admin_comments
  end
  
end
