ActiveAdmin.register CreatorPreference do
  menu :parent => "USERS", :priority => 4
  # actions :index, :show       # <TODO CL>
  config.batch_actions = false        
  scope :all, :default => true
  
  
  # Configuration for Sidebar Filters
  filter :user
  filter :is_ready, :as => :select


  # Configuration for Creator_Preferences Index Page
  config.per_page = 15
  config.sort_order = "id_asc"
  
  index do
    column :experiment do |creator_preference|
      link_to "Experiment ##{creator_preference.user.experiment_id}", admin_experiment_path(creator_preference.user.experiment_id)
    end
    column :round, :sortable => :round_id do |creator_preference|
      link_to "Round #{creator_preference.round.number}", admin_round_path(creator_preference.round_id)
    end
    column :group do |creator_preference|
      link_to "Group #{creator_preference.group.name}", admin_group_path(creator_preference.group_id)
    end
    column :user, :sortable => :user_id  do |creator_preference|
      link_to "User #{creator_preference.user_id}", admin_user_path(creator_preference.user_id)
    end    
    column :is_ready, :sortable => :is_ready do |creator_preference|
      div :class => "admin-center-column" do 
        creator_preference.is_ready.yesno
      end
    end
    column :finished_round, :sortable => :finished_round do |creator_preference|
      div :class => "admin-center-column" do 
        creator_preference.finished_round.yesno
      end
    end
    default_actions
  end
  
  
  # Configuration for Creator_Preferences Show Page
  show do |creator_preference|
    attributes_table do
      row :experiment do |creator_preference|
        link_to "Experiment ##{creator_preference.user.experiment_id}", admin_experiment_path(creator_preference.user.experiment_id)
      end
      row :round do |creator_preference|
      link_to "Round #{creator_preference.round.number}", admin_round_path(creator_preference.round_id)
      end
      row :group do |creator_preference|
        link_to "Group #{creator_preference.group.name}", admin_group_path(creator_preference.group_id)
      end
      row :user do |creator_preference|
        link_to "User #{creator_preference.user_id}", admin_user_path(creator_preference.user_id)
      end
      row :is_ready do |creator_preference|
        creator_preference.is_ready.yesno
      end
      row :finished_round do |creator_preference|
        creator_preference.finished_round.yesno
      end
      row :credits_not_spent
      row :total_return_from_projects
      row :total_return
    end
    active_admin_comments
  end
  
end
