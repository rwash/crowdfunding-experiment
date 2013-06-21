module ApplicationHelper
   
  def generate_project_name       # <TODO CL> Revise, lots of duplication with the Reseeding Names.
  	@project_name = $project_names[0]
  	$project_names.delete($project_names[0])

  	# if we run out of names refill the array again
  	if $project_names == []
  		reseed_names
  	end
    return @project_name
  end      


  def reseed_names        # <TODO CL> Revise.
  	require 'csv'
  	$project_names = []
  	CSV.foreach("colors4.csv", :headers => false) do |row|
  	  $project_names << row[0]
  	end

  	$project_names.each do |n|
  		n.gsub!(";",'')
  	end 
  end

end