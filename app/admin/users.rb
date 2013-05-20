ActiveAdmin.register User do
  menu :parent => "EXPERIMENTS", :priority => 7

  # Configuration for Sidebar Filters
  filter :experiment
  filter :name
  filter :payout
  filter :questions_payout
  filter :times_viewed_instructions
  filter :created_at


  # Configuration for Users Index Page
  config.per_page = 15
  config.sort_order = "id_asc"

  index do
    selectable_column
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
    column :created_at
    default_actions
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