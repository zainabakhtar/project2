class Curriculum < ApplicationRecord
  before_destroy :never_destroy
  has_many :camps

  # validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  ratings_array = [0] + (100..3000).to_a
  validates :min_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validates :max_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validate :max_rating_greater_than_min_rating
validate :deactivate_curriculum

  # scopes
  scope :alphabetical, -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_rating, ->(rating) { where("min_rating <= ? and max_rating >= ?", rating, rating) }


  private
  def max_rating_greater_than_min_rating

    return true if self.max_rating.nil? || self.min_rating.nil?
    unless self.max_rating > self.min_rating
      errors.add(:max_rating, "must be greater than the minimum rating")
    end
  end



  def never_destroy
    errors.add(:family,"you cannot destroy this")
    throw(:abort)
  end


  
   def deactivate_curriculum
    upcoming_camps_with_registrations = self.camps.upcoming.map{|c| c.registrations}.flatten
    if !self.active && !upcoming_camps_with_registrations.empty?
      errors.add(:base, "Curriculum cannot be inactive because as it's part of an upcoming camp")
      return false
    end
  end

  
end
