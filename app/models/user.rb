class User < ApplicationRecord
    has_secure_password

    has_one :instructor
    has_one :family

    
  validates :username, presence: true, uniqueness: { case_sensitive: false}

  validates :role, inclusion: { in: %w[admin instructor parent]}
  
  validates_presence_of :password, on: :create 
  validates_presence_of :password_confirmation, on: :create 
  validates_confirmation_of :password
  validates_length_of :password, minimum: 4, allow_blank: true
#email and phone from instructor file, transferred
validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format" }
  validates :phone, format: { with: /\A\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}\z/, message: "should be 10 digits (area code needed) and delimited with dashes only", allow_blank: true }

   before_save :extract_phone_numbers
   before_save :samepasswords


  
  private
  def extract_phone_numbers
    self.phone = self.phone.to_s.gsub!(/[^0-9]/,"")      #stackoverflow. This gets rid of - and brackets so that the numbers are just digits
  end
  
  def samepasswords
    self.password ==self.password_confirmation
  end

end
