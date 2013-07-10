ActiveAdmin.register DonorPreference do
  menu :parent => "USERS", :priority => 3
  actions :index, :show  
  config.batch_actions = false    
  scope :all, :default => true


  # Configuration for Sidebar Filters
  filter :user
  filter :is_ready, :as => :select
  

  # Configuration for Donor_Preferences Index Page
  config.per_page = 15
  config.sort_order = "id_asc"
  index do
    column :experiment  do |donor_preferences|
      link_to "Experiment ##{donor_preferences.user.experiment_id}", admin_experiment_path(donor_preferences.user.experiment_id)
    end
    column :round do |donor_preferences|
      link_to "Round #{donor_preferences.round.number}", admin_round_path(donor_preferences.round_id)
    end
    column :group do |donor_preferences|
       link_to "Group #{donor_preferences.group.name}", admin_group_path(donor_preferences.group_id)
    end
    column :user, :sortable => :user_id  do |donor_preferences|
      link_to "User #{donor_preferences.user_id}", admin_user_path(donor_preferences.user_id)
    end
    column :is_ready, :sortable => :is_ready do |donor_preference|
      div :class => "admin-center-column" do 
         donor_preference.is_ready.yesno
      end
    end
    column :finished_round, :sortable => :finished_round do |donor_preference|
      div :class => "admin-center-column" do 
         donor_preference.finished_round.yesno
      end
    end
    default_actions
  end
  
  
  # Configuration for Donor_Preferences Show Page
  show do |donor_preferences|
    attributes_table do
      row :experiment do |donor_preferences|
        link_to "Experiment ##{donor_preferences.user.experiment_id}", admin_experiment_path(donor_preferences.user.experiment_id)
      end
      row :round do |donor_preferences|
      link_to "Round #{donor_preferences.round.number}", admin_round_path(donor_preferences.round_id)
      end
      row :group do |donor_preferences|
        link_to "Group #{donor_preferences.group.name}", admin_group_path(donor_preferences.group_id)
      end
      row :user do |donor_preferences|
        link_to "User #{donor_preferences.user_id}", admin_user_path(donor_preferences.user_id)
      end
      row :is_ready do |donor_preference|
        donor_preference.is_ready.yesno
      end
      row :finished_round do |donor_preference|
        donor_preference.finished_round.yesno
      end  
      row :credits_not_donated
      row :total_return_from_projects
      row :credits_to_be_returned 
      row :total_return
      row :project_display_order
    end
    active_admin_comments
  end
  
end
