require 'test_helper'
require 'base64'

class RegistrationTest < ActiveSupport::TestCase
 should belong_to(:student)
  should belong_to(:camp)
  should have_one(:family).through(:student)
  
  should validate_numericality_of(:camp_id).only_integer
  should validate_numericality_of(:student_id).only_integer

  context "Within context" do
    setup do 
      create_family_users
      create_families
      create_students
      create_curriculums
      create_more_curriculums
      create_locations
      create_upcoming_camps
      create_camps
      create_registrations
    end
    
    teardown do
      delete_families
      delete_students
      delete_curriculums
      delete_locations
      delete_camps
      #delete_registrations
    end
    
    
     should "have an alphabetical scope" do
      assert_equal ["Ahmed, Ali", "Ahmed, Ali", "Hussain, Zainab"], Registration.alphabetical.all.map{|r| r.student.name}
    end

    should "have an for_camp scope" do
      assert_equal [@ali_tactics_camp1,@zainab_tactics_camp1], Registration.for_camp(@camp1).sort_by{|r| r.student.first_name}
    end
    

    should "show t the student is active" do
      create_inactive_students
      bad= FactoryBot.build(:registration, student: @shireen, camp: @camp1)
      deny bad.valid?
      delete_inactive_students
    end

    should "show the camp is active" do
      bad = FactoryBot.build(:registration, student: @zainab, camp: @camp3)
      deny bad.valid?
    end

    should "show student has an appropriate rating to enroll in a camp" do
      zainab_tactics = FactoryBot.build(:registration, student: @zainab, camp: @camp2)
      assert zainab_tactics.valid?
      ali_smithmorra = FactoryBot.build(:registration, student: @ali, camp: @camp22)
      deny ali_smithmorra.valid?
    end

    should "show student is not registered for another camp at the same time" do
     newcamp = FactoryBot.create(:camp, curriculum: @endgames, location: @north,start_date: Date.new(2018,12,23), end_date: Date.new(2019,7,27), time_slot: "pm") 
      bad = FactoryBot.build(:registration, student: @zainab, camp: newcamp)
      deny bad.valid?
     
    end
    
# credit card tests

    should "valid and invalid credit card numbers" do
      #invalid card number
      @zainab_tactics_camp1.credit_card_number = "412345678901234" #invalid number from contexts
      @zainab_tactics_camp1.expiration_month = Date.current.month
      @zainab_tactics_camp1.expiration_year = Date.current.year
      deny @zainab_tactics_camp1.valid?
      # valid card number
      @zainab_tactics_camp1.credit_card_number = "341234567890123" #valid number from contexts
      @zainab_tactics_camp1.expiration_month = Date.current.month
      @zainab_tactics_camp1.expiration_year = Date.current.year
      assert @zainab_tactics_camp1.valid?
    end


    should "valid and invalid expiration dates" do
      #invalid card number
      @zainab_tactics_camp1.credit_card_number = "5123456789012345" #invalid date
      @zainab_tactics_camp1.expiration_month = Date.current.month
      @zainab_tactics_camp1.expiration_year = 1.year.ago.year
      deny @zainab_tactics_camp1.valid?
      # valid card number
      @zainab_tactics_camp1.credit_card_number = "5123456789012345" #valid date
      @zainab_tactics_camp1.expiration_month = Date.current.month
      @zainab_tactics_camp1.expiration_year = Date.current.year
      assert @zainab_tactics_camp1.valid?
    end


 should "identify credit card by pattern" do
        @zainab_tactics_camp1.credit_card_number = 4123456789012345
        assert_equal "VISA", "#{@zainab_tactics_camp1.credit_card_type}" 
    end
    
    should "show payment receipt and should allow it to be generated once only" do
      @zainab_tactics_camp1.payment = nil
      @zainab_tactics_camp1.save
      @zainab_tactics_camp1.credit_card_number = "30012345678901"
      @zainab_tactics_camp1.expiration_month = Date.current.month 
      @zainab_tactics_camp1.expiration_year = Date.current.year


      @zainab_tactics_camp1.pay
      assert_equal "camp: #{@zainab_tactics_camp1.camp_id}; student: #{@zainab_tactics_camp1.student_id}; amount_paid: #{@zainab_tactics_camp1.camp.cost}; card: #{@zainab_tactics_camp1.credit_card_type} ****#{@zainab_tactics_camp1.credit_card_number[-4..-1]}", Base64.decode64(@zainab_tactics_camp1.payment)
      @zainab_tactics_camp1.reload

      deny @zainab_tactics_camp1.pay #does not allow double payment
    end

    
end
end
