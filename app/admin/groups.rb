ActiveAdmin.register Group do
  menu :parent => "EXPERIMENTS", :priority => 2
  scope :all, :default => true
  scope :group_a do |group|
    group.where(:name => "A")
  end
  scope :group_b do |group|
    group.where(:name => "B")
  end
    
  
  # Configuration for Sidebar Filters
  filter :experiment, :as => :select, :collection => Group.uniq.pluck(:experiment_id)
  filter :name, :as => :select, :collection => Group.uniq.pluck(:name)
  filter :created_at
  
  
  # Configuration for Groups Index Page
  config.sort_order = "id_asc"  
  config.per_page = 15
  
  index do
    selectable_column
    column :id
    column :name, :sortable => :name do |group|
       div :class => "admin-center-column" do 
          group.name
       end
    end
    column :experiment do |group|
      link_to "Experiment ##{group.experiment_id}", admin_experiment_path(group.experiment_id)
    end
    column :created_at
    default_actions
  end


  # Configuration for Groups Show Page
  show do |group|
    attributes_table do
      row :id
      row :experiment do |group|
        link_to "Experiment ##{group.experiment_id}", admin_experiment_path(group.experiment_id)
      end
      row :name
      row :created_at
    end
    active_admin_comments
  end



  # Configuration for Groups Edit Page
  form do |f|                         
   f.inputs "New Group" do       
     f.input :experiment, :collection => Group.uniq.pluck(:experiment_id)
     f.input :name, :as => :select, :collection => Group.uniq.pluck(:name)
   end                               
   f.actions                         
  end
  
end
