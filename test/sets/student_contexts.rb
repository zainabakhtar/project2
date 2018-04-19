module Contexts
  module StudentContexts
    def create_students
      @zainab   = FactoryBot.create(:student, family: @hussain, first_name: "Zainab", last_name: "Hussain", date_of_birth: 19.years.ago.to_date, rating: 2309, active: true)
      @ali  = FactoryBot.create(:student, family: @ahmed, first_name: "Ali", last_name: "Ahmed", date_of_birth: 12.years.ago.to_date, rating: 980, active: true)
    @yasmin= FactoryBot.create(:student, family: @ahmed, first_name: "Yasmin", last_name: "Ahmed", date_of_birth: 12.years.ago.to_date, rating: 980, active: true)
 # @zuhair = FactoryBot.create(:student, family: @ahmed, first_name: "zuhair", last_name: "Ahmed", date_of_birth: 17.years.ago.to_date,rating: 1100, active: false)
    end

    def delete_students
      @zainab.delete
      @ali.delete
      @yasmin.delete
     #  @zuhair.delete
    end

    def create_inactive_students
      @shireen = FactoryBot.create(:student, family: @ahmed, first_name: "Shireen", last_name: "Ahmed", date_of_birth: 17.years.ago.to_date,rating: nil, active: false)
    
   
    end

    def delete_inactive_students
      @shireen.delete
     
    end

    def create_more_students
      @alamdar = FactoryBot.create(:student, family: @imran, first_name: "Alamdar", last_name: "Imran", date_of_birth: 12.years.ago.to_date, rating: 2104, active: true)
      @bigmo  = FactoryBot.create(:student, family: @qamar, first_name: "Mohammed", last_name: "Qamar", date_of_birth: 10.years.ago.to_date, rating: 900, active: true)
    end

    def delete_more_students
      @alamdar.delete
      @bigmo.delete
    end
  end
end