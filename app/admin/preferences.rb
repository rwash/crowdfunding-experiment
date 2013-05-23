ActiveAdmin.register Preferences do
  actions :index, :show
  config.batch_actions = false  
  menu :parent => "[TO BE REMOVED]", :priority => 1
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
  filter :group_name, :label => "Group", :as => :select, :collection => Group.uniq.pluck(:name)
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
  
  
  # Configuration for Preferences Index Page
  config.sort_order = "user_id_asc"
  config.per_page = 15
  index do
    # column :user_id, :sortable => :user_id do |preference|
    #    div :class => "admin-center-column" do 
    #       link_to "#{preference.user.name}", admin_user_path(preference.user_id)
    #    end
    # end
    # column "Group" do |preference|
    #    div :class => "admin-center-column" do 
    #       link_to "Group #{preference.group.name}", admin_group_path(preference.user.group_id)
    #    end
    # end
    # column :round, :sortable => :round_id do |preference|
    #    div :class => "admin-center-column" do 
    #       link_to "Round #{preference.round.number}", admin_round_path(preference.round_id)
    #    end
    # end
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
    default_actions
  end
  
  
  # Configuration for Preferences Show Page
  show do |preference|
    attributes_table do
      row :id
      row :group do |preference|
        link_to "Group #{preference.user.group_id}", admin_group_path(preference.user.group_id)
      end
      row :round do |preference|
        link_to "Round #{preference.round_id}", admin_round_path(preference.round_id)
      end
      row :user do |preference|
        link_to "User #{preference.user_id}", admin_user_path(preference.user_id)
      end
      row :flag do |preference|
        preference.flag.yesno
      end
      row :flag_note
      row :finished_and_ready do |preference|
        preference.finished_and_ready.yesno
      end
      row :ready_to_start do |preference|
        preference.ready_to_start.yesno
      end
      row :contributed do |preference|
        preference.contributed.yesno
      end
      row :timer_expired do |preference|
        preference.timer_expired.yesno
      end
      row :round_payout
      row :kind_of
      row :a_payout
      row :b_payout
      row :c_payout
      row :d_payout
    end
    active_admin_comments
  end
  
end