require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  
  should belong_to(:family)
  should have_many(:registrations)
  should have_many(:camps).through(:registrations)

  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_presence_of(:family_id)

  should allow_value(1392).for(:rating)
  should_not allow_value(454.245).for(:rating)
  should_not allow_value("blahblah").for(:rating)

  should allow_value(4.years.ago.to_date).for(:date_of_birth)
  should_not allow_value(Date.today).for(:date_of_birth)


  context "Within context" do
    setup do 
     create_family_users
      create_families
      create_students

      
    end
    
    teardown do
      delete_family_users
      delete_families
      delete_students
      
      
    end

    should "callback for no rating" do
      create_inactive_students
      assert @shireen.rating
      delete_inactive_students
    end
    
    should "student_inactive method" do
      assert @zainab.active
      @zainab.student_inactive
      deny @zainab.active
    end
    
    should "alphabetical scope" do
      assert_equal ["Ahmed, Ali", "Ahmed, Yasmin", "Hussain, Zainab"], Student.alphabetical.all.map(&:name)
    end

    should "show three active students" do
      create_inactive_students
      assert_equal 3, Student.active.size
      assert_equal ["Ali", "Yasmin","Zainab"], Student.active.all.map(&:first_name).sort
      delete_inactive_students
    end
    
    should "show one inactive student" do
      create_inactive_students
      assert_equal 1, Student.inactive.size
      assert_equal ["Shireen"], Student.inactive.all.map(&:first_name).sort
      delete_inactive_students
    end

    should "below_rating scope" do
      assert_equal 2, Student.below_rating(1000).size
      assert_equal ["Ali", "Yasmin"], Student.below_rating(1000).all.map(&:first_name).sort      
    end

    should "at_or_above_rating scope" do
      assert_equal 1, Student.at_or_above_rating(2000).size
      assert_equal [ "Zainab"], Student.at_or_above_rating(2000).all.map(&:first_name).sort      
    end

    should "name method" do
      assert_equal "Hussain, Zainab", @zainab.name
      assert_equal "Ahmed, Ali", @ali.name
    end
    
    should "proper_name method" do
      assert_equal "Zainab Hussain", @zainab.proper_name
      assert_equal "Ali Ahmed", @ali.proper_name
    end

    should "age method" do 
      assert_equal 19, @zainab.age
      assert_equal 12, @ali.age
    end
    
 #question 4
 
      should "allow a student with no past camps to be destroyed + all upcoming registrations removed" do

      assert @yasmin.destroy

      create_curriculums
      create_locations
      create_camps
      create_registrations
      assert_equal 2, @camp1.registrations.count
      assert @zainab.destroy
      @camp1.reload
      assert_equal 1, @camp1.registrations.count

    end

    should "deactive a student with past camps rather than destroy" do
      create_curriculums
      create_locations
      create_camps
      create_registrations
      assert @ali.active
      @camp4.update_attribute(:start_date, 45.weeks.ago.to_date)
      @camp4.update_attribute(:end_date, 40.weeks.ago.to_date)
      assert_equal 1, @camp4.registrations.count
      assert_equal 2, @ali.registrations.count
      deny @ali.destroy #cannot be destroyed
      @camp4.reload
      deny @ali.active # student is deactivated
    end



#number 5

should "remove upcoming registrations for inactive student" do
      create_curriculums
      create_locations
      create_camps
      create_registrations
      assert_equal 1, @zainab.registrations.count
      @zainab.make_inactive
      @zainab.reload
      assert_equal 0, @zainab.registrations.count

    end

    
    
    
    
  end
end
