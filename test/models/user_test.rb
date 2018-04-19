require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_one(:instructor)
  should have_secure_password


  should validate_presence_of(:username)
  should validate_presence_of(:password)
  should validate_presence_of(:password_confirmation)

 should validate_presence_of(:email)
  should validate_uniqueness_of(:email).case_insensitive


  should allow_value("zainab.111@hotmail.com").for(:email)
  should_not allow_value("hjguyg").for(:email)


  should allow_value("999-999-9999").for(:phone)
  should allow_value("342.222.2229").for(:phone)

  should allow_value("admin").for(:role)
  should allow_value("instructor").for(:role)
  should allow_value("parent").for(:role)
  should_not allow_value("other").for(:role)


  context "Within context" do
    setup do
      create_users
      create_instructors
      
    end
    
    teardown do
      delete_instructors
      delete_users
    end

    should "shows  phone number as numbers only" do
      assert_equal "4122682323", @user_mark.phone
    end
    
    
    should "show unique username" do
      assert_equal "mark123", @user_mark.username
      @user_mark.username = "alex123"
      deny @user_mark.valid?, "#{@user_mark.username}"
    end

    should "show unique email" do
      assert_equal "mark@cmu.edu", @user_mark.email
      @user_mark.email = "alex@cmu.edu"
      deny @user_mark.valid?, "#{@user_mark.email}"
    end
    
    should "passwords must be matching" do
      bad_user_1 = FactoryBot.build(:user, username: "alex", instructor: @alex, password: "something", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryBot.build(:user, username: "alex", instructor: @alex, password: "something", password_confirmation: "somethinh222")
      deny bad_user_2.valid?
    end
    
    should " passwords must be at least four characters" do
      bad_user = FactoryBot.build(:user, username: "tank", instructor: @alex, password: "no")
      deny bad_user.valid?
    end

   
end
end
