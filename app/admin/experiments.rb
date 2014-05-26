ActiveAdmin.register Experiment do
  menu :parent => "EXPERIMENTS", :priority => 1  
  config.batch_actions = false 
  scope :all, :default => true
  scope :started do |experiment|
    experiment.where(:started => true)
  end
  scope :finished do |experiment|
    experiment.where(:finished => true)
  end   
    
  
  # Configuration for Sidebar Filters
  filter :started, :as => :select
  filter :finished, :as => :select
  filter :return_credits, :as => :select
  
  
  # Configuration for Experiments Index Page
  config.sort_order = "id_asc"  
  config.per_page = 15
  index do
    column "Experiment" do |experiment|
      "Experiment ##{experiment.id}"
    end
    column :started, :sortable => :started do |experiment|
       div :class => "admin-center-column" do 
          experiment.started.yesno
       end
    end
    column :finished, :sortable => :finished do |experiment|
       div :class => "admin-center-column" do 
          experiment.finished.yesno
       end
    end          
    column :return_credits, :sortable => :name do |experiment|
       div :class => "admin-center-column" do 
          experiment.return_credits.yesno
       end
    end
    default_actions
  end
  
  
  # Configuration for Experiments Show Page
  show do |experiment|
    attributes_table do
      row "Experiment" do |experiment|
        "Experiment ##{experiment.id}"
      end
      row :current_round_number
      row :started do |experiment|
        experiment.started.yesno
      end
      row :finished do |experiment|
        experiment.finished.yesno
      end   
      row :return_credits do |experiment|
        experiment.return_credits.yesno
      end      
      row :payout_condition
      row :start_time
      row :end_time
    end
    active_admin_comments
  end


  # Configuration for Experiments Edit Page
  form do |f|                         
   f.inputs "New Experiment" do       
     f.input :return_credits, :as => :select, :include_blank => false, collection: options_for_select([["Yes", true], ["No", false]], true)
     f.input :payout_condition, :as => :select, :include_blank => false, collection: options_for_select(Payouts.uniq.pluck(:condition_name))
   end                               
   f.actions                         
  end  
  
end
