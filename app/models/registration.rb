class Registration < ApplicationRecord
  require 'base64'
    
  belongs_to :camp
  belongs_to :student
  has_one :family, through: :student
  
  attr_accessor :credit_card_number
  attr_accessor :expiration_year
  attr_accessor :expiration_month
  
  validates :camp_id, presence: true, numericality: { only_integer: true }
  validates :student_id, presence: true, numericality: {  only_integer: true }
  validate :restrict_students, on: :create #those that are active
  validate :restrict_camps, on: :create   #those that are active
  validate :student_rating, on: :create
 validate :not_already_registered, on: :create
  validate :credit_card_number_validity
  validate :expiration_date_validity

  scope :for_camp, ->(camp_id) { where(camp_id: camp_id) }
  scope :alphabetical, -> { joins(:student).order('students.last_name, students.first_name') }
  
  #credit card methods
def pay
    return false unless self.payment.nil?
    self.payment = Base64.encode64("camp: #{self.camp_id}; student: #{self.student_id}; amount_paid: #{self.camp.cost}; card: #{self.credit_card_type} ****#{self.credit_card_number[-4..-1]}")
    self.save!
    self.payment
  end
  
   def credit_card
    CreditCard.new(self.credit_card_number, self.expiration_year, self.expiration_month)
  end

  
  def credit_card_type
    credit_card.type.nil? ? "This card type does not exist" : credit_card.type.name
  end


   def credit_card_number_validity
    return false if self.expiration_year.nil? || self.expiration_month.nil?
    if self.credit_card_number.nil? || credit_card.type.nil?
      errors.add(:credit_card_number, "this card number is not valid")
      return false
    end
    true
  end

  def expiration_date_validity
    return false if self.credit_card_number.nil? 
    if self.expiration_year.nil? || self.expiration_month.nil? || credit_card.expired?
      errors.add(:expiration_year, "Your card has expired. It is below 2018.")
      return false
    end
    true
  end
end

#other methods
    def restrict_students
      return if self.student.nil?
    errors.add(:student, "is not existing/active in the system") unless self.student.active
  end

  def restrict_camps
    return if self.camp.nil?
    errors.add(:camp, "is not existing/active in the system") unless self.camp.active
  end
  
   def student_rating
    return true if camp_id.nil? || student_id.nil?
    unless (camp.curriculum.min_rating..camp.curriculum.max_rating).cover?(student.rating) #student rating is not covered between the min and max rating
      errors.add(:base, "This students rating is not appropriate and so cannot be part of  the camp")
    end


  def not_already_registered
    return true if self.camp.nil? || self.student.nil?
    if Camp.where(start_date: self.camp.start_date, time_slot: self.camp.time_slot).map{|c| c.students }.flatten.include?(self.student)
      errors.add(:base, "student is registered for another camp at the same time- conflicts are not allowed.")
    end
  end


end
