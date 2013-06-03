ActiveAdmin.register CreatorPreference do
  menu :parent => "USERS", :priority => 2
  # actions :index, :show  
  # config.batch_actions = false  
  scope :all, :default => true
  
  
  # Configuration for Sidebar Filters
  filter :user
  # filter :round, :as => :select, :collection_select( :round, :id, Round.all, :id, :number )     # <TODO CL>
  filter :is_ready, :as => :select


  # Configuration for Creator_Preferences Index Page
  config.per_page = 15
  config.sort_order = "id_asc"
  
  index do
    selectable_column    
    column :id
    column :experiment do |creator_preference|
      link_to "Experiment ##{creator_preference.user.experiment_id}", admin_experiment_path(creator_preference.user.experiment_id)
    end
    column :group do |creator_preference|
       link_to "Group #{creator_preference.user.group.name}", admin_group_path(creator_preference.user.group_id)
    end
    column :user, :sortable => :user_id  do |creator_preference|
      link_to "User #{creator_preference.user_id}", admin_user_path(creator_preference.user_id)
    end
    column :round do |creator_preference|
      link_to "Round #{creator_preference.round.number}", admin_round_path(creator_preference.round_id)
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
      row :group do |creator_preference|
        link_to "Group #{creator_preference.user.group.name}", admin_group_path(creator_preference.user.group_id)
      end
      row :user do |creator_preference|
        link_to "User #{creator_preference.user_id}", admin_user_path(creator_preference.user_id)
      end
      row :round do |creator_preference|
      link_to "Round #{creator_preference.round.number}", admin_round_path(creator_preference.round_id)
      end
      row :is_ready do |creator_preference|
        creator_preference.is_ready.yesno
      end
      row :finished_round do |creator_preference|
        creator_preference.finished_round.yesno
      end
    end
    active_admin_comments
  end
  
  # Configuration for Creator_Preferences Batch Actions
  ActiveAdmin.register CreatorPreference do
    batch_action :is_ready, :priority => 1 do |selection|
      CreatorPreference.find(selection).each do |creator_preference|
        creator_preference.is_ready = true
        creator_preference.save
      end
      redirect_to admin_creator_preferences_path
    end
  end
  
end
