ActiveAdmin.register Round do
  # actions :index, :show
  config.batch_actions = false  
  menu :parent => "EXPERIMENTS", :priority => 3
  scope :all, :default => true
  scope :part_a_started do |round|
    round.where(:part_a_started => true)
  end
  scope :part_a_finished do |round|
    round.where(:part_a_finished => true)
  end
  scope :part_b_started do |round|
    round.where(:part_b_started => true)
  end
  scope :part_b_finished do |round|
    round.where(:part_b_finished => true)
  end
    
  
  # Configuration for Sidebar Filters
  filter :experiment, :as => :select, :collection => Experiment.uniq.pluck(:id)
  # filter :group, :as => :select, :collection => Group.uniq.pluck(:name)  # TODO - DOESN'T SELECT RECORDS
  filter :number, :label => "Round"
  filter :part_a_started, :as => :select
  filter :part_a_finished, :as => :select
  filter :part_b_started, :as => :select
  filter :part_b_finished, :as => :select
  filter :start_time
  filter :end_time
  
  
  # Configuration for Rounds Index Page
  config.sort_order = "id_asc"
  config.per_page = 15
  index do
    column :experiment, :sortable => :experiment_id do |round|
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
    column :part_a_started, :sortable => :part_a_started do |round|
       div :class => "admin-center-column" do 
          round.part_a_started.yesno
       end
    end
    column :part_a_finished, :sortable => :part_a_finished do |round|
       div :class => "admin-center-column" do 
          round.part_a_finished.yesno
       end
    end
    column :part_b_started, :sortable => :part_b_started do |round|
       div :class => "admin-center-column" do 
          round.part_b_started.yesno
       end
    end
    column :part_b_finished, :sortable => :part_b_finished do |round|
       div :class => "admin-center-column" do 
          round.part_b_finished.yesno
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
      row :part_a_started do |round|
        round.part_a_started.yesno
      end
      row :part_a_finished do |round|
        round.part_a_finished.yesno
      end
      row :part_b_started do |round|
        round.part_b_started.yesno
      end
      row :part_b_finished do |round|
        round.part_b_finished.yesno
      end
      row :start_time
      row :end_time
    end
    active_admin_comments
  end
  
  
  # Configuration for Rounds Edit Page        <TODO CL> Remove this and disable Edit when done Troubleshooting
  form do |f|                         
   f.inputs "New Round" do       
     f.input :part_a_started, :as => :select, :include_blank => false
     f.input :part_a_finished, :as => :select, :include_blank => false
     f.input :part_b_started, :as => :select, :include_blank => false
     f.input :part_b_finished, :as => :select, :include_blank => false
   end                               
   f.actions                         
  end
  
  
  # Configuration for Rounds CSV Output  <TODO CL> Remove if Implement This
  csv do
    column "Experiment" do |round|
      "Experiment ##{round.group.experiment_id}"
    end
    column "Round Id" do |round|
      round.id
    end
    column "Round Number" do |round|
      round.number
    end
    column "Group" do |round|
      round.group.name
    end
    column "Custom Output #1" do |round|
      (round.id*3)
    end
    column "Custom Output #2" do |round|
      (round.id/3.142)
    end
    column "Custom Output #3" do |round|
      "ABC"
    end
  end
  
end
