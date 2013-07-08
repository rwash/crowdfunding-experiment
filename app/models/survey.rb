class Survey < ActiveRecord::Base
  validates_presence_of :q1
  validates_presence_of :q2   
  validates_presence_of :q3  
  validates_presence_of :q4
  validates_presence_of :q5
  validates_presence_of :q6  
  validates_presence_of :q7_a
  validates_presence_of :q7_b
  validates_presence_of :q8  
  # validates_presence_of :q9       # <TODO CL> Include validation for text fields in Surveys Controller.
  # validates_presence_of :q10      
  validates_presence_of :q11  
  validates_presence_of :q12_a
  validates_presence_of :q12_b
  validates_presence_of :q12_c  
  validates_presence_of :q12_d   
  belongs_to :user

end
