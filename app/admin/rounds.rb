ActiveAdmin.register Round do
  actions :index, :show
  config.batch_actions = false    
  menu :parent => "EXPERIMENTS", :priority => 2
  scope :all, :default => true
  scope "TEST" do |round|
    round.where(:round_type => "TEST")
  end
  scope "LIVE" do |round|
    round.where(:round_type => "LIVE")
  end  
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
  filter :experiment, :as => :select
  filter :number, :label => "Round"
  
  
  # Configuration for Rounds Index Page
  config.sort_order = "id_asc"
  config.per_page = 15
  index do 
    column :experiment, :sortable => :experiment_id do |round|
      link_to "Experiment ##{round.experiment_id}", admin_experiment_path(round.experiment_id)
    end
    column :round_type, :sortable => :round_type do |round|
       div :class => "admin-center-column" do 
          round.round_type
       end
    end
    column :round, :sortable => :number do |round|
       div :class => "admin-center-column" do 
          round.number
       end
    end
    column :round_complete, :sortable => :round_complete do |round|
      div :class => "admin-center-column" do
        round.round_complete.yesno
      end
    end
    default_actions
  end
  
  
  # Configuration for Rounds Show Page
  show do |round|
    attributes_table do
      row :experiment do |round|
        link_to "Experiment ##{round.experiment_id}", admin_experiment_path(round.experiment_id)
      end 
      row :round_type do |round|
        round.round_type
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
      row :round_complete do |round|
        round.round_complete.yesno
      end
      row :summary_complete do |round|
        round.summary_complete.yesno
      end
      row :start_time
      row :end_time
    end
    active_admin_comments
  end
 

  # # Configuration for Rounds CSV Output  <TODO CL> Remove if Implement This
  # csv do
  #   column "Experiment" do |round|
  #     "Experiment ##{round.experiment_id}"
  #   end
  #   column "Round Id" do |round|
  #     round.id
  #   end
  #   column "Round Number" do |round|
  #     round.number
  #   end
  #   column "Group" do |round|
  #     round.group.name
  #   end
  #   column "Custom Output #1" do |round|
  #     (round.id*3)
  #   end
  #   column "Custom Output #2" do |round|
  #     (round.id/3.142)
  #   end
  #   column "Custom Output #3" do |round|
  #     "ABC"
  #   end
  # end  
  
end
