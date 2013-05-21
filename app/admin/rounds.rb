ActiveAdmin.register Round do
  actions :index, :show
  config.batch_actions = false  
  menu :parent => "EXPERIMENTS", :priority => 3
  scope :all, :default => true
  scope :started do |round|
    round.where(:started => true)
  end
  scope :finished do |round|
    round.where(:finished => true)
  end
    
  
  # Configuration for Sidebar Filters
  filter :experiment, :as => :select
  filter :group, :as => :select
  filter :number, :as => :select
  filter :started, :as => :select
  filter :finished, :as => :select
  filter :number
  filter :start_time
  filter :end_time
  
  
  # Configuration for Rounds Index Page
  config.sort_order = "id_asc"
  config.per_page = 15
  index do
    column :experiment do |round|
      link_to "Experiment ##{round.group.experiment_id}", admin_experiment_path(round.group.experiment_id)
    end
    column :group, :sortable => :group_id do |round|
      link_to "Group #{round.group.name}", admin_group_path(round.group_id)
    end
    column :round, :sortable => :number do |round|
       div :class => "admin-center-column" do 
          round.number
       end
    end
    column :started, :sortable => :started do |round|
       div :class => "admin-center-column" do 
          round.started.yesno
       end
    end
    column :finished, :sortable => :finished do |round|
       div :class => "admin-center-column" do 
          round.finished.yesno
       end
    end
    column :start_time, :sortable => :start_time do |round|
       div :class => "admin-center-column" do 
          round.start_time
       end
    end
    column :end_time, :sortable => :end_time do |round|
       div :class => "admin-center-column" do 
          round.end_time
       end
    end
    default_actions
  end
  
  
  # Configuration for Rounds Show Page
  show do |round|
    attributes_table do
      row :experiment do |round|
        link_to "Experiment ##{round.group.experiment_id}", admin_experiment_path(round.group.experiment_id)
      end
      row :group do |round|
        link_to "Group #{round.group.name}", admin_group_path(round.group_id)
      end
      row "Round" do |round|
        "Round #{round.number}"
      end
      row :started do |round|
        round.started.yesno
      end
      row :finished do |round|
        round.finished.yesno
      end
      row :start_time
      row :end_time
    end
    active_admin_comments
  end
  
end
