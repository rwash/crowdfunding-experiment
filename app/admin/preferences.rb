ActiveAdmin.register Preferences do
  menu :parent => "EXPERIMENTS", :priority => 6
  scope :all, :default => true
  scope :flag do |preference|
    preference.where(:flag => true)
  end
  scope :finished_and_ready do |preference|
    preference.where(:finished_and_ready => true)
  end
  scope :ready_to_start do |preference|
    preference.where(:ready_to_start => true)
  end
  scope :timer_expired do |preference|
    preference.where(:timer_expired => true)
  end
    
  
  # Configuration for Sidebar Filters
  filter :user, :as => :select
  filter :flag, :as => :select
  filter :finished_and_ready, :as => :select
  filter :ready_to_start, :as => :select
  filter :contributed, :as => :select
  filter :timer_expired, :as => :select
  filter :round_payout
  filter :kind_of
  filter :a_payout
  filter :b_payout
  filter :c_payout
  filter :d_payout
  filter :created_at
  
  
  # Configuration for Preferences Index Page
  config.sort_order = "id_asc"
  config.per_page = 15

  index do
    selectable_column
    column :id
    column :group
    column :flag, :sortable => :flag do |preference|
       div :class => "admin-center-column" do 
          preference.flag.yesno
       end
    end
    column :finished_and_ready, :sortable => :finished_and_ready do |preference|
       div :class => "admin-center-column" do 
          preference.finished_and_ready.yesno
       end
    end
    column :ready_to_start, :sortable => :ready_to_start do |preference|
       div :class => "admin-center-column" do 
          preference.ready_to_start.yesno
       end
    end
    column :timer_expired, :sortable => :timer_expired do |preference|
       div :class => "admin-center-column" do 
          preference.timer_expired.yesno
       end
    end          
    column :round_payout, :sortable => :round_payout do |preference|
       div :class => "admin-center-column" do 
          preference.round_payout
       end
    end
    column :kind_of, :sortable => :kind_of do |preference|
       div :class => "admin-center-column" do 
          preference.kind_of
       end
    end
    column :a_payout, :sortable => :a_payout do |preference|
       div :class => "admin-center-column" do 
          preference.a_payout
       end
    end
    column :b_payout, :sortable => :b_payout do |preference|
       div :class => "admin-center-column" do 
          preference.b_payout
       end
    end
    column :c_payout, :sortable => :c_payout do |preference|
       div :class => "admin-center-column" do 
          preference.c_payout
       end
    end
    column :d_payout, :sortable => :d_payout do |preference|
       div :class => "admin-center-column" do 
          preference.d_payout
       end
    end
    column :created_at
    default_actions
  end
  

  # Configuration for Preferences Edit Page
  form do |f|                         
   f.inputs "New Preference" do       
     f.input :user, :as => :select
     f.input :group, :as => :select
     f.input :flag, :as => :select
     f.input :a_payout
     f.input :b_payout
     f.input :c_payout
     f.input :d_payout              
   end                               
   f.actions                         
  end
  
end
