ActiveAdmin.register Group do
  actions :index, :show
  config.batch_actions = false  
  menu :parent => "EXPERIMENTS", :priority => 2
  scope :all, :default => true
  scope :group_a do |group|
    group.where(:name => "A")
  end
  scope :group_b do |group|
    group.where(:name => "B")
  end
    
  
  # Configuration for Sidebar Filters
  filter :experiment, :as => :select, :collection => Group.uniq.pluck(:experiment_id)  # CHECK THIS WORKS
  filter :name, :as => :select, :collection => Group.uniq.pluck(:name)     # CHECK THIS WORKS
  
  
  # Configuration for Groups Index Page
  config.sort_order = "id_asc"  
  config.per_page = 15
   index do
    column :experiment do |group|
      link_to "Experiment ##{group.experiment_id}", admin_experiment_path(group.experiment_id)
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
        link_to "Experiment ##{group.experiment_id}", admin_experiment_path(group.experiment_id)
      end
      row :group do |group|
        "Group #{group.name}"         
      end
    end
    active_admin_comments
  end

end
