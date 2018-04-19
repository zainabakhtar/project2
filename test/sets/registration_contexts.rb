 module Contexts
  module RegistrationContexts
      
      
     def create_registrations
      @zainab_tactics_camp1    = FactoryBot.create(:registration, camp: @camp1, student: @zainab, credit_card_number: 5123456789012345, expiration_year: 2019, expiration_month: 12)   # a valid VISA card)
      @ali_endgames_camp4 = FactoryBot.create(:registration, camp: @camp4, student: @ali, credit_card_number: 5123456789012345, expiration_year: 2019, expiration_month: 12)
      @ali_tactics_camp1 = FactoryBot.create(:registration, camp: @camp1, student: @ali, credit_card_number: 5123456789012345, expiration_year: 2019, expiration_month: 12)
      
    end

    def delete_registrations
      @zainab_tactics_camp1.delete
      @ali_endgames_camp4.delete
      @ali_endgames_camp1.delete
    end
end
end