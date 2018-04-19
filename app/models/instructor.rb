class Instructor < ApplicationRecord
  # relationships
  has_many :camp_instructors
  has_many :camps, through: :camp_instructors
  belongs_to :user

  # validations
  validates_presence_of :first_name, :last_name
  

  # scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :needs_bio, -> { where('bio IS NULL') }
  # scope :needs_bio, -> { where(bio: nil) }  # this also works...


      def make_inactive
        self.active = false
        self.save!
      end


  # class methods
  def self.for_camp(camp)
    # the 'instructive way'... (which I told you if you asked me for help)
    CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
    # the easy way... 
    # camp.instructors
  end

  # question 3
   before_update :deactive_when_inactive

def deactive_when_inactive
    if !self.active && !self.user.nil?
      self.user.active = false
      self.user.save
    end
  end

  # instance methods
  def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end

# question 2 - dealing with inactive
after_rollback :inactive_and_remove_upcoming_camps

  def inactive_and_remove_upcoming_camps
    if @destroyable == false
      self.camp_instructors.select{|ci| ci.camp.start_date >= Date.current}.each{|ci| ci.destroy}
      self.make_inactive
    end
    @destroyable = nil
  end

#question 2 dealing with destroying
before_destroy do
    instructors_past_camps
    if errors.present?
      @destroyable = false
      throw(:abort)
    else
      self.user.destroy
    end
  end

#helper method
  def instructors_past_camps
    unless self.camps.past.empty?
      errors.add(:base, 'You cannot delete this instructor because he/she tuaght past camps.')
    end
  end
  

end
