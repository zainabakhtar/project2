module Contexts
  module CampContexts
    def create_camps
      # assumes create_curriculums prior
      @camp1 = FactoryBot.create(:camp, curriculum: @tactics, location: @cmu ,start_date: Date.new(2018,12,23), end_date: Date.new(2019,7,27), time_slot: "pm")  #upcoming camp 
      @camp2 = FactoryBot.create(:camp, curriculum: @tactics, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,27), location: @cmu,time_slot: "am")
      @camp3 = FactoryBot.create(:camp, curriculum: @tactics, time_slot: "pm", active: false, location: @cmu)
      @camp4 = FactoryBot.create(:camp, curriculum: @endgames, start_date: Date.new(2018,7,23), end_date: Date.new(2018,7,27), time_slot: "pm", location: @cmu,)
   
    end

    def delete_camps
      @camp1.delete
      @camp2.delete
      @camp3.delete
      @camp4.delete

    end
    
    
    def create_sametime_camp
      @duplicatecamp=FactoryBot.create(:camp, curriculum: @endgames, location: @north ,start_date: Date.new(2018,12,23), end_date: Date.new(2019,7,27), time_slot: "pm")
   @duplicatecamp1=FactoryBot.create(:camp, curriculum: @endgames, location: @north ,start_date: Date.new(2018,12,23), time_slot: "pm")
    end
    
   def delete_sametime_camp
      @duplicatecamp.delete
      @duplicatecamp1.delete
    end
    
    
    
    

    def create_past_camps
      # assumes create_more_curriculums prior
      @camp10 = FactoryBot.create(:camp, curriculum: @principles, start_date: Date.new(2018,6,3), end_date: Date.new(2018,6,7), time_slot: "am", location: @cmu)
      @camp11 = FactoryBot.create(:camp, curriculum: @nimzo, start_date: Date.new(2018,6,3), end_date: Date.new(2018,6,7), time_slot: "pm", location: @north)
      @camp12 = FactoryBot.create(:camp, curriculum: @positional, start_date: Date.new(2018,6,10), end_date: Date.new(2018,6,14), time_slot: "am", location: @north)
      @camp13 = FactoryBot.create(:camp, curriculum: @principles, start_date: Date.new(2018,6,10), end_date: Date.new(2018,6,14), time_slot: "pm", location: @north)
      @camp10.update_attributes(:start_date => Date.new(2017,7,3), :end_date => Date.new(2017,7,7))
      @camp11.update_attributes(:start_date => Date.new(2017,7,3), :end_date => Date.new(2017,7,7))
      @camp12.update_attributes(:start_date => Date.new(2017,7,10), :end_date => Date.new(2017,7,14))
      @camp13.update_attributes(:start_date => Date.new(2017,7,10), :end_date => Date.new(2017,7,14))
    end

    def delete_past_camps
      @camp10.delete
      @camp11.delete
      @camp12.delete
      @camp13.delete
    end

    def create_upcoming_camps
      # assumes create_more_curriculums prior
      @camp20 = FactoryBot.create(:camp, curriculum: @principles, start_date: Date.new(2018,6,11), end_date: Date.new(2018,6,15), time_slot: "am", location: @north)
      @camp21 = FactoryBot.create(:camp, curriculum: @nimzo, start_date: Date.new(2018,6,11), end_date: Date.new(2018,6,15), time_slot: "pm", location: @cmu)
      @camp22 = FactoryBot.create(:camp, curriculum: @positional, start_date: Date.new(2018,6,18), end_date: Date.new(2018,6,22), time_slot: "am", location: @cmu)
      @camp23 = FactoryBot.create(:camp, curriculum: @openings, start_date: Date.new(2018,6,18), end_date: Date.new(2018,6,22), time_slot: "pm", location: @cmu)
      @camp24 = FactoryBot.create(:camp, curriculum: @principles, start_date: Date.new(2018,6,25), end_date: Date.new(2018,6,29), time_slot: "am", location: @cmu)
      @camp25 = FactoryBot.create(:camp, curriculum: @adv_tactics, start_date: Date.new(2018,6,25), end_date: Date.new(2018,6,29), time_slot: "pm", location: @cmu)
      @camp26 = FactoryBot.create(:camp, curriculum: @principles, start_date: Date.new(2018,7,9), end_date: Date.new(2018,7,13), time_slot: "am", location: @cmu)
      @camp27 = FactoryBot.create(:camp, curriculum: @nimzo, start_date: Date.new(2018,7,9), end_date: Date.new(2018,7,13), time_slot: "pm", location: @cmu)
    end

    def delete_upcoming_camps
      @camp20.delete
      @camp21.delete
      @camp22.delete
      @camp23.delete
      @camp24.delete
      @camp25.delete
      @camp26.delete
      @camp27.delete
    end
  end
end