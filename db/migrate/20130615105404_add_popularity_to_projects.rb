class AddPopularityToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :popularity, :string
  end
end
