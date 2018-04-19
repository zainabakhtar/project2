# require needed files
require './test/sets/curriculum_contexts'
require './test/sets/instructor_contexts'
require './test/sets/camp_contexts'
require './test/sets/camp_instructor_contexts'
require './test/sets/location_contexts'
require './test/sets/registration_contexts'
require './test/sets/user_contexts'
require './test/sets/family_contexts'
require './test/sets/student_contexts'
require './test/sets/credit_card_contexts'


module Contexts
  # explicitly include all sets of contexts used for testing 
  include Contexts::CurriculumContexts
  include Contexts::InstructorContexts
  include Contexts::CampContexts
  include Contexts::CampInstructorContexts
  include Contexts::LocationContexts
  include Contexts::RegistrationContexts
  include Contexts::UserContexts
  include Contexts::FamilyContexts
  include Contexts::StudentContexts
  include Contexts::CreditCardContexts


  def create_cuke_contexts
    create_curriculums
    create_more_curriculums
    
    
    create_instructors
    create_more_instructors
    
    create_camps
    create_past_camps
    create_upcoming_camps
    create_sametime_camp
    
    
    create_camp_instructors
    create_more_camp_instructors
    
  
    
    create_families
    create_inactive_families
    create_more_families
    
    create_students
    create_inactive_students
    create_more_students
    
    create_users
    create_more_users
    create_family_users
    
    create_active_locations
    create_inactive_locations
    create_locations_never_used_by_camps
    
    create_registrations
    
    create_valid_cards
    create_invalid_card_lengths
    create_invalid_card_prefixes
    create_invalid_card_dates
    

  end
  
  # def delete_cuke_contexts
  #   delete_curriculums
  #   delete_active_locations
  #   delete_instructors
  #   delete_camps
  #   delete_camp_instructors
  #   delete_more_curriculums
  #   delete_more_instructors
  #   delete_past_camps
  #   delete_upcoming_camps
  #   delete_more_camp_instructors
  #   delete_families
  #   delete_inactive_families
  #   delete_more_families
  #   delete_students
  #   delete_inactive_students
  #   delete_more_students
  # end

end