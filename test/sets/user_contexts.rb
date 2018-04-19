module Contexts
  module UserContexts

    def create_users
      @user_mark = FactoryBot.create(:user,  username: "mark123", role: "instructor", email:"mark@cmu.edu", phone: "412-268-2323", password: "1234", password_confirmation: "1234", active:true)
      @user_alex = FactoryBot.create(:user, username: "alex123", role: "instructor", email:"alex@cmu.edu", phone: "412-268-2323", password: "1234", password_confirmation: "1234",active:true)
    @user_rachel =FactoryBot.create(:user,  username: "rachel123", role: "instructor",email:"rachel@cmu.edu",phone: "412-268-2323",password: "1234", password_confirmation: "1234", active:true)

    
    end

    def delete_users
      @user_mark.delete
      @user_alex.delete
      @user_rachel.delete
  
    end

    def create_more_users
      @user_jon = FactoryBot.create(:user,username: "jon123", password: "1234", password_confirmation: "1234", role: "instructor")
      @user_brad  = FactoryBot.create(:user,  username: "brad123", password: "1234", password_confirmation: "1234", role: "instructor")
      @user_ripta    = FactoryBot.create(:user,  username: "ripta123", password: "1234", password_confirmation: "1234", role: "instructor")
    end

    def delete_more_users
      @user_jon.delete
      @user_brad.delete
      @user_ripta.delete
    end    
    

def create_family_users
   @user_hussain = FactoryBot.create(:user, username: "hussain", role: "parent",phone: "412-268-2323",password: "1234", password_confirmation: "1234", active:true)
      @user_ahmed = FactoryBot.create(:user, username: "ahmed", role: "parent",phone: "412-268-2323",password: "1234", password_confirmation: "1234", active:true)
      @user_park    = FactoryBot.create(:user, username: "park", role: "parent",phone: "412-268-2323",password: "1234", password_confirmation: "1234", active:true)
      @user_qamar  = FactoryBot.create(:user, username: "qamar", role: "parent",phone: "412-268-2323",password: "1234", password_confirmation: "1234", active:true)
      @user_imran  = FactoryBot.create(:user, username: "imran", role: "parent",phone: "412-268-2323",password: "1234", password_confirmation: "1234", active:true)
    
end

def delete_family_users
  @user_hussain.delete
      @user_ahmed.delete
      @user_park.delete
      @user_qamar.delete
      @user_imran.delete
    end

  end
end