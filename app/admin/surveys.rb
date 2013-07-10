ActiveAdmin.register Survey do
  menu :parent => "USERS", :priority => 4
  actions :index, :show      
  config.batch_actions = false 
  scope :all, :default => true
  scope "Survey Complete" do |survey|
    survey.where(:survey_complete => true)
  end                            
  
  
  # Configuration for Sidebar Filters
  filter :survey_complete, :as => :select
 
   
  # Configuration for Surveys Index Page
  config.sort_order = "id_asc"  
  config.per_page = 15
  index do
    column :user
    column :survey_complete, :sortable => :survey_complete do |survey|
      survey.survey_complete.yesno
    end    
    default_actions
  end
  
      
  # Configuration for Surveys Show Page
  show do |survey|
    attributes_table do
      row :user
      row :survey_complete do |survey|
        survey.survey_complete.yesno
      end
      row :q1
      row :q2 
      row :q3 do |survey|
        survey.q3.yesno
      end
      row :q4
      row :q5 do |survey|
        survey.q5.yesno
      end
      row :q6 do |survey|
        survey.q6.yesno
      end  
      row :q7_a
      row :q7_b
      row :q8 do |survey|
        survey.q8.yesno
      end        
      row :q9
      row :q10
      if survey.user.user_type == "Creator"
        row :q11
        row :q12_a
        row :q12_b
        row :q12_c
        row :q12_d                 
      end
    end
    active_admin_comments
  end
    
end