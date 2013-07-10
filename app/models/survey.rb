class Survey < ActiveRecord::Base   
  attr_accessor :user_type
  validates :q1, :presence => { :message => "Can't be blank" }
  validates :q2, :presence => { :message => "Can't be blank" }               
  validates :q3, :inclusion => { :in => [true, false], :message => "Can't be blank" }
  validates :q4, :presence => { :message => "Can't be blank" } 
  validates :q5, :inclusion => { :in => [true, false], :message => "Can't be blank" } 
  validates :q6, :inclusion => { :in => [true, false], :message => "Can't be blank" }  
  validates :q7_a, :presence => { :message => "Can't be blank" } 
  validates :q7_b, :presence => { :message => "Can't be blank" } 
  validates :q8, :inclusion => { :in => [true, false], :message => "Can't be blank" }    

  validates :q11, :presence => { :message => "Can't be blank" }, :if => :user_creator?  
  validates :q12_a, :presence => { :message => "Can't be blank" }, :if => :user_creator? 
  validates :q12_b, :presence => { :message => "Can't be blank" }, :if => :user_creator? 
  validates :q12_c, :presence => { :message => "Can't be blank" }, :if => :user_creator? 
  validates :q12_d, :presence => { :message => "Can't be blank" }, :if => :user_creator?         
  belongs_to :user     
    

  def user_creator?
    if self.user_type == "Creator"
      return true
    else
      return false
    end
  end

end
