class Family < ApplicationRecord


  belongs_to :user
  has_many :students
  has_many :registrations, through: :students

 
  validates_presence_of :family_name, :parent_first_name
  
 
  scope :alphabetical, -> { order('family_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  
  
      def make_inactive
        self.active = false
        self.save!

      end
      
  before_destroy :never_destroy


  def never_destroy
    errors.add(:family,"you cannot destroy this")
    throw(:abort)
  end


 before_update :family_inactive


  def family_inactive
    if self.active == false
      self.registrations.select{|i| i.camp.start_date >= Date.current}.each{|i| i.destroy}
      self.students.each{|s| s.make_inactive}
    end
  end


  
    


 

  
end
