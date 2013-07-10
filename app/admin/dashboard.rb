ActiveAdmin.register_page "Dashboard" do
  menu :priority => 1, :label => "DASHBOARD"

  content :title => "Crowdfunding Experiment - Dashboard" do

    columns do
      column do
        div :class => "admin-center-column" do         
          panel "Experiments" do
            table_for Experiment.all do
              column ("Experiment") {|experiment| link_to("Experiment ##{experiment.id}", admin_experiment_path(experiment.id)) } 
              column "Current Round" do |experiment|
                experiment.current_round_number
              end
              column "Live Status" do |experiment|  
                link_to "Status", experiment_status_path(experiment)  
              end
              column "History" do |experiment|  
                link_to "History", experiment_history_summary_path(experiment)  
              end
              column "User Payouts" do |experiment|  
                link_to "Payouts", experiment_payouts_path(experiment)  
              end              
            end 
          end
        end
      end
    end
  end
end
