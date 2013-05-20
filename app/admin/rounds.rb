ActiveAdmin.register Round do
  menu :parent => "EXPERIMENTS", :priority => 3
  scope :all, :default => true
  scope :started do |round|
    round.where(:started => true)
  end
  scope :finished do |round|
    round.where(:finished => true)
  end
    
  
  # Configuration for Sidebar Filters
  filter :group, :as => :select
  filter :started, :as => :select
  filter :finished, :as => :select
  filter :number
  filter :start_time
  filter :end_time
  filter :created_at
  
  
  # Configuration for Rounds Index Page
  config.sort_order = "id_asc"
  config.per_page = 15

  index do
    selectable_column
    column :id
    column :experiment
    column :number, :sortable => :number do |round|
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
    column :created_at
    default_actions
  end
  
end
