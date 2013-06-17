ActiveAdmin.register Group do
  # actions :index, :show
  config.batch_actions = false   
  menu :parent => "EXPERIMENTS", :priority => 3
  scope :all, :default => true
  scope :group_a do |group|
    group.where(:name => "A")
  end
  scope :group_b do |group|
    group.where(:name => "B")
  end
    
  
  # Configuration for Sidebar Filters
  filter :name, :label => "Group Name", :as => :select, :collection => Group.uniq.pluck(:name)
  
  
  # Configuration for Groups Index Page
  config.sort_order = "id_asc"  
  config.per_page = 15
   index do
    column :experiment do |group|
      link_to "Experiment ##{group.round.experiment_id}", admin_experiment_path(group.round.experiment_id)
    end  
    column "Round" do |group|
      link_to "Round ##{group.round.number}", admin_round_path(group.round_id)
    end  
    column "Group Name", :sortable => :name do |group|
      "Group #{group.name}"
    end
    default_actions
  end


  # Configuration for Groups Show Page
  show do |group|
    attributes_table do
      row :experiment do |group|
        link_to "Experiment ##{group.round.experiment_id}", admin_experiment_path(group.round.experiment_id)
      end
      row "Round" do |group|
        link_to "Round ##{group.round.number}", admin_round_path(group.round_id)
      end    
      row :group do |group|
        "Group #{group.name}"         
      end
    end
    active_admin_comments
  end

end
