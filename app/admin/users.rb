ActiveAdmin.register User do
  actions :index, :show, :edit, :update
  config.batch_actions = false  
  menu :parent => "EXPERIMENTS", :priority => 6
  scope :all, :default => true
  
  
  # Configuration for Sidebar Filters
  filter :experiment, :as => :select, :collection => Experiment.uniq.pluck(:id)
  filter :group_name, :label => "Group", :as => :select, :collection => Group.uniq.pluck(:name)
  filter :name
  filter :payout
  filter :questions_payout


  # Configuration for Users Index Page
  config.per_page = 15
  config.sort_order = "id_asc"
  index do
    column :experiment, :sortable => :experiment_id  do |user|
      if user.experiment_id != nil
        link_to "Experiment ##{user.experiment_id}", admin_experiment_path(user.experiment_id)
      end
    end
    column :group, :sortable => :group_id  do |user|
      if user.group_id != nil
        link_to "Group #{user.group.name}", admin_group_path(user.group_id)
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
    column :payout, :sortable => :payout do |user|
       div :class => "admin-center-column" do 
          user.payout
       end
    end
    column :questions_payout, :sortable => :questions_payout do |user|
       div :class => "admin-center-column" do 
          user.questions_payout
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
      row :group do |user|
        if user.group_id != nil
          link_to "Group #{user.group_id}", admin_group_path(user.group_id)
        end
      end
      row :name
      row :payout
      row :questions_payout
      row :times_viewed_instructions
      row :question_1A
      row :question_1B
      row :question_2A
      row :question_2B
      row :question_2C
      row :question_2D
    end
    active_admin_comments
  end
  

  # Configuration for Users Edit Page
  form do |f|                         
   f.inputs "New User" do       
     f.input :experiment, :as => :select
     f.input :name
     f.input :password 
   end                               
   f.actions                         
  end
  
end