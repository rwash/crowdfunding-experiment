ActiveAdmin.register DonorPreference do
  menu :parent => "USERS", :priority => 3
  actions :index, :show  
  config.batch_actions = false  
  scope :all, :default => true


  # Configuration for Donor_Preferences Index Page
  config.per_page = 15
  config.sort_order = "id_asc"
  index do
    column :id
    column :experiment, :sortable => :experiment_id  do |donor_preferences|
      link_to "Experiment ##{donor_preferences.user.experiment_id}", admin_experiment_path(donor_preferences.user.experiment_id)
    end
    column :group, :sortable => :group_id  do |donor_preferences|
       link_to "Group #{donor_preferences.user.group.name}", admin_group_path(donor_preferences.user.group_id)
    end
    column :user, :sortable => :user_id  do |donor_preferences|
      link_to "User #{donor_preferences.user_id}", admin_user_path(donor_preferences.user_id)
    end
    column :round, :sortable => :round_id  do |donor_preferences|
      link_to "Round #{donor_preferences.round.number}", admin_round_path(donor_preferences.round_id)
    end
    default_actions
  end
  
  
  # Configuration for Donor_Preferences Show Page
  show do |donor_preferences|
    attributes_table do
      row :experiment do |donor_preferences|
        link_to "Experiment ##{donor_preferences.user.experiment_id}", admin_experiment_path(donor_preferences.user.experiment_id)
      end
      row :group do |donor_preferences|
        link_to "Group #{donor_preferences.user.group.name}", admin_group_path(donor_preferences.user.group_id)
      end
      row :user do |donor_preferences|
        link_to "User #{donor_preferences.user_id}", admin_user_path(donor_preferences.user_id)
      end
      row :round do |donor_preferences|
      link_to "Round #{donor_preferences.round.number}", admin_round_path(donor_preferences.round_id)
      end
    end
    active_admin_comments
  end
  
end
