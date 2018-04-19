module Contexts
  module FamilyContexts

    def create_families
      @hussain= FactoryBot.create(:family, user: @user_hussain, family_name: "Hussain", parent_first_name: "Akhtar", active: true)
      @ahmed= FactoryBot.create(:family,  user: @user_ahmed, family_name: "Ahmed", parent_first_name: "Mushtaq", active: true)
    end

    def delete_families
      @hussain.delete
      @ahmed.delete
    end

    def create_inactive_families
      @park = FactoryBot.create(:family, user: @user_park, family_name: "Park", parent_first_name: "Bob", active: false)
    end

    def delete_inactive_families
      @park.delete
    end

    def create_more_families
      @qamar   = FactoryBot.create(:family, user: @user_qamar, family_name: "Qamar", parent_first_name: "Mohammed")
      @imran   = FactoryBot.create(:family, user: @user_imran, family_name: "Imran", parent_first_name: "Zafar")
    end    

    def delete_more_families
      @qamar.delete
      @imran.delete
    end   

  end
end

