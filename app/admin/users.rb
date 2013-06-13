ActiveAdmin.register User do
  actions :index, :show
  config.batch_actions = false  
  menu :parent => "USERS", :priority => 1
  scope :all, :default => true
  scope :creators do |user|
    user.where(:user_type => "Creator")
  end
  scope :donors do |user|
    user.where(:user_type => "Donor")
  end
  
  
  # Configuration for Sidebar Filters
  filter :experiment, :as => :select, :collection => Experiment.uniq.pluck(:id)
  filter :name
  filter :type
  filter :payout


  # Configuration for Users Index Page
  config.per_page = 15
  config.sort_order = "id_asc"
  index do
    column :experiment, :sortable => :experiment_id  do |user|
      if user.experiment_id != nil
        link_to "Experiment ##{user.experiment_id}", admin_experiment_path(user.experiment_id)
      end
    end
    column :name, :sortable => :name do |user|
       div :class => "admin-center-column" do 
          user.name
       end
    end
    column :password, :sortable => :password do |user|
       div :class => "admin-center-column" do 
          user.password
       end
    end
    column :user_type, :sortable => :user_type do |user|
       div :class => "admin-center-column" do 
          user.user_type
       end
    end
    column :payout, :sortable => :payout do |user|
       div :class => "admin-center-column" do 
          user.payout
       end
    end
    default_actions
  end
  
  
  # Configuration for Users Show Page
  show do |user|
    attributes_table do
      row :experiment do |user|
        if user.experiment_id != nil
          link_to "Experiment ##{user.experiment_id}", admin_experiment_path(user.experiment_id)
        end
      end
      row :name
      row :user_type
      row :payout
      row :times_viewed_instructions
    end
    active_admin_comments
  end
  
end