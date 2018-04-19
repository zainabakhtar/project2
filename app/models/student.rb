
class Student < ApplicationRecord

    
  belongs_to :family
  has_many :registrations
  has_many :camps, through: :registrations

  validates_presence_of :first_name, :last_name, :family_id
  validates_date :date_of_birth, :before => lambda { Date.today }, allow_blank: true, on: :create #date cannot be the current date and can only be blank when a new form is shown
  validates :rating, numericality: { only_integer: true}, inclusion: { in: (0..3000) }, allow_blank: true   #same from curriculum.rb

  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :below_rating, ->(ceiling) { where('rating < ?', ceiling) }
  scope :at_or_above_rating, ->(floor) { where('rating >= ?', floor) }
  
  def name
    "#{self.last_name}, #{self.first_name}"
  end

  def proper_name
    "#{self.first_name} #{self.last_name}"
  end

  def age
    return nil if date_of_birth.blank?
    (Time.now.to_s(:number).to_i - date_of_birth.to_time.to_s(:number).to_i)/10e9.to_i #from stackoverflow
  end
  
  
  def student_inactive
    self.active = false
    self.save!
  end
before_save :rating_blank
#question 3
  def rating_blank
    self.rating ||= 0
  end
  #question 4
  #allow students to be destroyed in all cases except--> remove upcoming registration or deactivate
  before_destroy do 
   check_if_ever_registered_for_past_camp
   if errors.present?
     @destroyable = false
    self.active = false
    self.save!
     throw(:abort)
   else
     remove_upcoming_registrations #student can be deleted so remove upcoming registrations
   end
  end
  
  #helper method
#if a student has been in a past camp then the student should be deactivated rather than deleted.
  def check_if_ever_registered_for_past_camp
    return if self.registrations.empty?
    if !self.registrations.select{|r| r.camp.start_date < Date.current}.empty?
      errors.add(:base, "if a student has been in a past camp then the student should be deactivated")
    end
  end
  
before_update :remove_upcoming_registrations_if_inactive
#question 5
  #if a student is inactive, then all upcoming registrations should be removed automatically
  def remove_upcoming_registrations_if_inactive
    remove_upcoming_registrations if !self.active 
  end
    
    #helper method
  def remove_upcoming_registrations
    return true if self.registrations.empty?
    self.registrations.select{|r| r.camp.start_date >= Date.current}.each{ |ur| ur.destroy }
  end
  
  
      def make_inactive
        self.active = false
        self.save!
      end

end
