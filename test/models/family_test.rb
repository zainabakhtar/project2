require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  should belong_to(:user)
  should have_many(:students)
should have_many(:registrations).through(:students)

  should validate_presence_of(:family_name)
  should validate_presence_of(:parent_first_name)

  context "Within context" do
    setup do 
      create_family_users
      create_families
      create_inactive_families
    end
    
    teardown do
      delete_families
      delete_family_users
      delete_inactive_families

    end
    
    should "family cannot be ever destroyed" do
      deny @hussain.destroy
    end
    

    should "alphabetical order" do
      assert_equal ["Ahmed", "Hussain", "Park"], Family.alphabetical.all.map(&:family_name)
    end

    should "show two active families" do
      assert_equal 2, Family.active.size
      assert_equal ["Ahmed", "Hussain"], Family.active.all.map(&:family_name).sort
    end
    
    should "show  one inactive family" do
      assert_equal 1, Family.inactive.size
      assert_equal ["Park"], Family.inactive.all.map(&:family_name).sort
    end

should "make student inactive" do
  create_students
  assert @zainab.active
  assert @zainab.make_inactive
  deny @zainab.active
end

should "remove upcoming registrations after inactive" do
      create_curriculums
      create_locations
      create_camps
      create_students
      create_registrations
      assert_equal 2, @ahmed.registrations.count
      @ahmed.make_inactive
      @ahmed.reload
      assert_equal 0, @ahmed.registrations.count

    end




  end
end
